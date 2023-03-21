
#powershell script to convert favorites bookmarks to distribution.ini
$jsonData = Get-Content -Raw /Users/mccrackent/Documents/VM/sharedFolders/bookmarks-2023-03-20.json | ConvertFrom-Json
#typecode 1=site, 2=folder



$base = $jsonData.children

$itemRoot = "toolbar"
function collectSite($b){
    $b | ForEach-Object {
        write-host "ItemRoot:"$itemroot
        $index = $_.index
        $title = $_.title
        $thisJson = @{"itemRoot"=$itemroot;"title"=$title}
        if($_.typecode -eq 1){
            $uri = $_.uri
            $icon = $_.iconuri
            $thisJson.link = $uri
            $thisJson.icon = $icon
            write-host $thisJson
        }elseif($_.typecode -eq 2){
            $folder = $_.folder
            $itemroot = $folder
            $folderCount=$folderCount + 1
            $thisJson.folder = $itemroot
            $thisJson.folderId = $folderCount
            write-host  $thisJson
            collectFolder($_)}

    }
}


function collectFolder($a){
    $itemRoot = "BookmarksFolder-"+$folderCount
    write-host $itemRoot -ForegroundColor red
    write-host "index" $a.index
    write-host "title" $a.title
    if($a.children){
        collectSite($a.children)
    }
}


forEach($item in $base){
    if($item.root -eq "toolbarFolder"){$root = $item.children}
    }
    
collectSite($root)

<#forEach($child in $importData.children){
 if($child.root -eq "toolbarFolder"){
  
    forEach($itemLevel0 in $child.children){       
        if($itemLevel0.typeCode -eq 2){
            write-host "folder" -ForegroundColor Red
            write-host "index:" $itemLevel0.index
            write-host "title:" $itemLevel0.title
            forEach($itemLevel1 in $itemLevel0.children){
            write-host "site" -ForegroundColor green
                write-host "url:"$itemLevel1.uri
                write-host "title:"$itemLevel1.title
                write-host "index:"$itemLevel1.index
                write-host "icon:" $itemLevel1.iconuri
                if($itemLevel1.children){
                    write-host "children"
                }
            }
        }elseif($itemLevel0.typeCode -eq 1){
            write-host "site"
        }
        $itemLevel0.index
        $itemLevel0.uri
        

    }
   
 }


} #>
