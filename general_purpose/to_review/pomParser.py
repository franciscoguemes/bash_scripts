#!/usr/bin/env python3


# https://docs.python.org/2/library/xml.etree.elementtree.html
# https://stackoverflow.com/questions/16802732/reading-maven-pom-xml-in-python

#
# parsing maven pom.xml
# artifactId & version
#
from xml.etree import ElementTree

POM_FILE="/home/francisco/git/Uniscon/backoffice-aggregator/pom.xml"  # replace your path

# <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
namespaces = {'xmlns': 'http://maven.apache.org/POM/4.0.0',
              'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
              'xsi:schemaLocation': 'http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd' }

tree = ElementTree.parse(POM_FILE)
root = tree.getroot()

print(repr(root))

print("---------------------")

for version in root.findall('./xmlns:version', namespaces=namespaces):
    print(version.text)
    version.text="1.102-SNAPSHOT"

tree.write('output.xml')