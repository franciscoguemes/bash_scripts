#!/usr/bin/env python3

# https://docs.python.org/2/library/xml.dom.minidom.html
# https://stackoverflow.com/questions/1912434/how-do-i-parse-xml-in-python
# https://stackoverflow.com/questions/2502758/update-element-values-using-xml-dom-minidom

from xml.dom import minidom

#POM_FILE="/home/francisco/git/Uniscon/backoffice-aggregator/pom.xml"  # replace your path
POM_FILE = "/home/francisco/git/Uniscon/backoffice-aggregator/backoffice-sealed-cloud/pom.xml"
xmldoc = minidom.parse(POM_FILE)
itemlist = xmldoc.getElementsByTagName('version')

# print(len(itemlist))
# for s in itemlist:
#     print(s.toxml())
#     print(s.firstChild.data)
#     s.firstChild.data="1.102-SNAPSHOT"
#
# print("-----------------------------------")
# print(xmldoc.toxml())

version_item = None
for version_node in itemlist:
    parent_node = version_node.parentNode
    if parent_node.nodeName == "project":
        version_item = version_node
        break

version_item.firstChild.data="1.102-SNAPSHOT"
print(xmldoc.toxml())

