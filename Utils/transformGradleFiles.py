# Read in the file
import glob
import os.path

# Creo il file gradle.properties e aggiungo le proprieta che nn esistono

if os.path.isfile('gradle.properties'):
    with open('gradle.properties', 'r+') as fin:
        propsdata = fin.read()
else:
    with open('gradle.properties', 'w+') as fin:
        propsdata = fin.read()

if "ambiente" not in propsdata:
    # Add remote deployment support
    propsdata += "ambiente=ethernet\n"

# Write the file out again
with open('gradle.properties', 'w') as fout:
    fout.write(propsdata)

for file in glob.glob("*.gradle"):
    # Write the file out again
    with open(file, 'r') as fin:
        filedata = fin.read()

    # Add pi4j support and robots libraries
    filedata = filedata.replace(
    "//compile group: 'com.pi4j', name: 'pi4j-core', version: '1.1'",
    '''
 compile group: 'com.pi4j', name: 'pi4j-core', version: '1.1'
 /*
 ROBOTS
 */
 compile fileTree(dir: '../it.unibo.iss.libs/libs/unibo', include: 'labbaseRobotSam.jar')
 compile fileTree(dir: '../it.unibo.iss.libs/libs/unibo', include: 'uniboQactorRobot.jar')
 /*
 SONAR
 */
 compile fileTree(dir: '../Sonar/sonarRasp/', include: '*.jar')
    '''
    )

    copyDir = """
    copy {
    	from '../Sonar/SonarC/'
    	into 'src/dist/'
    	include '*.cpp'
    	include '*.c'
    }
    copy {
    	from '../Sonar/sonarRasp/srcMore/it/unibo/'
    	into 'src/dist/srcMore/it/unibo/'
    	include 'sonarrasp/*'
    }
    """

    if copyDir not in filedata:
        filedata = filedata.replace("""
/*
---------------------------------------------------------
PREPARE DISTRIBUTION
---------------------------------------------------------
*/
task copyInfoForDist << {
	copy {
		from 'audio'
		into 'src/dist/audio/'
		include '**/*.*'
 	}
	copy {
		from 'srcMore'
		into 'src/dist/srcMore/'
		include '**/*.*'
 	}
	copy {
		from '.'
		into 'src/dist/'
		include '*.pl'
		include '*.html'
 	}
	copy {
		from 'src'
		into 'src/dist/'
		include '*.qa'
		include '*.ddr'
		include '*.baseddr'
   	}
}
""",
"""
/*
---------------------------------------------------------
PREPARE DISTRIBUTION
---------------------------------------------------------
*/
task copyInfoForDist {
	doLast{
		copy {
			from 'audio'
			into 'src/dist/audio/'
			include '**/*.*'
	 	}
		copy {
			from 'srcMore'
			into 'src/dist/srcMore/'
			include '**/*.*'
	 	}
		copy {
			from '.'
			into 'src/dist/'
			include '*.pl'
			include '*.html'
	 	}
		copy {
			from 'src'
			into 'src/dist/'
			include '*.qa'
			include '*.ddr'
			include '*.baseddr'
	  }
      """+copyDir+"}}")

    filedata = filedata.replace("""
sourceSets {
	main {
		java {
			srcDirs = ['src' , 'src-gen'  ]
		}
	}
	test {
		 java {
		   srcDirs = ['test']
		 }
	}
}
""",
"""
sourceSets {
	main {
		java {
			srcDirs = ['src' , 'src-gen'  ]
			exclude 'dist/'
		}
	}
	test {
		 java {
		   srcDirs = ['test']
		 }
	}
}
"""
    )

    if "org.hidetake.ssh" not in filedata:
        # Add remote deployment support
        filedata = filedata.replace("apply plugin: 'jacoco'", '''
apply plugin: 'jacoco'

buildscript {
  repositories {
    jcenter()
  }
  dependencies {
    classpath 'org.hidetake:gradle-ssh-plugin:2.9.0'
    classpath 'org.yaml:snakeyaml:1.14'
  }
}

apply plugin: 'org.hidetake.ssh'
import org.yaml.snakeyaml.Yaml
        '''
        )

    if "DEPLOYMENT" not in filedata:
        filedata = filedata.replace("jar.dependsOn copyInfoForDist", '''
jar.dependsOn copyInfoForDist
/*
---------------------------------------------------------
DEPLOYMENT
---------------------------------------------------------
*/

def deploymentDir = "/home/pi/deploy-${mainClassName}-${version}"
def completeName = "$mainClassName-$version"
def tarFile = "${completeName}.tar"

def yaml = new Yaml()
def fistream = new FileInputStream("../Utils/contextConfig.yaml")
def systemConfig = (Map) yaml.load(fistream)
def contextName = mainClassName.tokenize('.')[2]

remotes {
  raspberry {
    //host = '192.168.1.213'
    host = systemConfig[ambiente][contextName]['host']
    user = 'pi'
    password = 'raspberry'
    //identity = file('id_rsa')
  }
}

task prepareRemote {
	doLast {
		ssh.run{
			session(remotes.raspberry){
				execute "mkdir -p $deploymentDir"
			}
		}
	}
}

task deploy {
  inputs.files(file("build/distributions/${tarFile}"))

  dependsOn 'build', 'prepareRemote'

  doLast {
    ssh.run {
	  session(remotes.raspberry) {
	    println "Copying distribution to remote"
	    put from: inputs.files, into: '/tmp/'

	    println "Extracting remote distribution"
	    execute "tar -xvf /tmp/$tarFile -C $deploymentDir"

	    println "Cleaning..."
	    remove "/tmp/$tarFile"
	  }
	}
  }
}

task jarDeploy {
  inputs.files(file("build/libs/*.jar"))

  dependsOn 'build', 'prepareRemote'

  doLast {
    ssh.run {
	  session(remotes.raspberry) {
	    println "Copying jars to remote"
	    put from: inputs.files, into: '$deploymentDir/${completeName}/'
	  }
	}
  }
}

/*
---------------------------------------------------------
RUN REMOTE
---------------------------------------------------------
*/
task executeRemote {
  doLast {
    ssh.run {
      session(remotes.raspberry) {
      	println "Executing -- ${jar.archiveName}"
        executeSudo "bash -c \\"cd $deploymentDir/$completeName; java -jar ${jar.archiveName}\\""
      }
    }
  }
}
        '''
        )
    if "SYS CONFIG" not in filedata:
        filedata += '''

/*
---------------------------------------------------------------------
SYS CONFIG: modifica tutti quanti i file prolog con le configurazioni di rete prima della compilazione
---------------------------------------------------------------------
*/

task configureSystem(type: Exec) {

	commandLine 'python', '../Utils/applySystemConfig.py', ambiente

}

assemble.dependsOn(configureSystem)
'''
    # Write the file out again
    with open(file, 'w') as fout:
        fout.write(filedata)
