# Read in the file
import glob
for file in glob.glob("*.gradle"):
    # Write the file out again
    with open(file, 'r') as fin:
        filedata = fin.read()

    # Add pi4j support and robots libraries
    filedata = filedata.replace("//compile group: 'com.pi4j', name: 'pi4j-core', version: '1.1'", '''
    compile group: 'com.pi4j', name: 'pi4j-core', version: '1.1'
    /*
    ROBOTS
    */
    compile fileTree(dir: '../it.unibo.iss.libs/libs/unibo', include: 'labbaseRobotSam.jar')
    compile fileTree(dir: '../it.unibo.iss.libs/libs/unibo', include: 'uniboQactorRobot.jar')
    '''
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
  }
}

apply plugin: 'org.hidetake.ssh'
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

remotes {
  raspberry {
    host = '192.168.1.213'
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
        executeSudo "bash -c \"cd $deploymentDir/$completeName; java -jar ${jar.archiveName}\""
      }
    }
  }
}
        '''
        )

    # Write the file out again
    with open(file, 'w') as fout:
        fout.write(filedata)
