#! /bin/bash
for d in Model*; do
	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<projectDescription>
	<name>$d</name>
	<comment></comment>
	<projects/>
	<natures>
		<nature>org.eclipse.jdt.core.javanature</nature>
		<nature>org.eclipse.xtext.ui.shared.xtextNature</nature>
	</natures>
	<buildSpec>
		<buildCommand>
			<name>org.eclipse.xtext.ui.shared.xtextBuilder</name>
			<arguments/>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.jdt.core.javabuilder</name>
			<arguments/>
		</buildCommand>
	</buildSpec>
	<linkedResources/>
</projectDescription>" >> $d/.project
done
