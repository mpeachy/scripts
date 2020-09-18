xquery version "3.0";
declare namespace ead = "urn:isbn:1-931666-22-9";
declare default element namespace "urn:isbn:1-931666-22-9";
declare copy-namespaces no-preserve, inherit;

import module namespace functx = "http://www.functx.com"
at "http://www.xqueryfunctions.com/xq/functx-1.0-doc-2007-01.xq";

(: Description audit survey example script :)
(: This query runs over a directory of EADs and produces an XML report listing all components at any level within the EADs that contain language matching a specified set of descriptive terms and variants (using regex). :)

(: Edit file path here to run over a different directory (change file path syntax if not working on Windows). :)

declare variable $COLL as document-node()+ := collection("file:///C:/Users/mpeach01/Desktop/harmful_description_work/Black/EAD?recurse=yes;select=*.xml");

(: Change the regex here to search for different terms. This is a simple example that searches for material related to slavery or enslaved persons. :)
<results>
    {
        let $contains_match := $COLL//ead:c/ead:*[not(self::ead:c) and matches(string(.), '(\s|^)(Blacks)(\s|$)', 'i')]
        
        for $match in $contains_match/parent::ead:c
        return
            <item>

                <unitid>{$match/child::ead:did/ead:unitid[1]}</unitid>
                <unittitle>{$match/child::ead:did/ead:unittitle}</unittitle>
                <subject>{$match/child::ead:controlaccess/ead:subject}</subject>
            </item>
    }
</results>

