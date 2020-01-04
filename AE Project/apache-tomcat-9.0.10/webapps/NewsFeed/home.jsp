<!DOCTYPE html>
<html>
<head>
    <title>News Feed</title>
</head>
<link rel="stylesheet" href="home.css"/>
<script type="text/javascript" src="jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        var jsonData = "";
        $.ajax({
            beforeSend: function(){
                $("#article").hide();
                $(".loader").show();
            },
            url: "firststruts/fetchJSON",
            success: function(response){
                if(response.indexOf("ERROR")){
                    jsonData = JSON.parse(response);
                    var newsTable = $("#article").find("tbody");
                    for(i = 0;i < jsonData.length;i++){
                        var str = "<tr><td><a href='"+jsonData[i].link+"'>"+jsonData[i].article+"</a></td><td>"+jsonData[i].publisher+"</td></tr>";
                        newsTable.append(str);
                    }
                    $("#article").show();
                    $(".loader").hide();
                }
                else{
                    $(".loader").hide();
                    $(".headerPart").hide();    
                    $(".errormsg").html("<h1>Sorry....Try Again</h1>");   
                }
            }
        });

        $("#sort").click(function(){
            if(jsonData != ""){
                $("#article").hide();
                $(".loader").show();
                jsonData.sort(function(a,b){
                    if (a.publisher == b.publisher) return 0;
                    if (a.publisher > b.publisher) return 1;
                    if (a.publisher < b.publisher) return -1;
                });
               var newsTable = $("#article").find("tbody");
               $(newsTable).empty();
               for(i = 0;i < jsonData.length;i++){
                    var str = "<tr><td><a href='"+jsonData[i].link+"'>"+jsonData[i].article+"</a></td><td>"+jsonData[i].publisher+"</td></tr>";
                    newsTable.append(str);
                } 
                $("#article").show();
                $(".loader").hide();
            }
        });

        $("#search").click(function(){
            var searchText = $("#searchText").val();
            if(searchText != ""){
                $("#article").hide();
                $(".loader").show();
                var newsTable = $("#article").find("tbody");
                $(newsTable).empty();
                for(i = 0;i < jsonData.length;i++){
                    if(jsonData[i].article.indexOf(searchText) >= 0){
                        var str = "<tr><td><a href='"+jsonData[i].link+"'>"+jsonData[i].article+"</a></td><td>"+jsonData[i].publisher+"</td></tr>";
                        newsTable.append(str);
                    }
                } 
                $("#article").show();
                $(".loader").hide();
            }
        });

        $("#clearSearch").click(function(){
            var searchText = $("#searchText").val();
            if(jsonData!="" && searchText!=""){
                $("#article").hide();
                $(".loader").show();
                var newsTable = $("#article").find("tbody");
                $(newsTable).empty();
                for(i = 0;i < jsonData.length;i++){
                    var str = "<tr><td><a href='"+jsonData[i].link+"'>"+jsonData[i].article+"</a></td><td>"+jsonData[i].publisher+"</td></tr>";
                    newsTable.append(str);
                }
                $("#searchText").val("");
                $("#article").show();
                $(".loader").hide();
            }
        });
    });
</script>
<body>
    <div class="loader"></div>
    <div class="errormsg"></div>
    <div class="headerPart">
        <div class="heading"> News Feed </div> 
        <div class="searchOrSort">
            <input id="searchText" type="text" placeholder="Search by Article" />
            <button id="search" class="search">Search</button>
            <button id="clearSearch" class="clear">Clear</button>
            <button id='sort' class="sort">Sort By Publisher</button>
        </div>
    </div>
    <div>
        <table id = "article">
            <thead>
                <th>Article</th>
                <th>Publisher</th>
            </thead>
            <tbody>            
            </tbody>
        </table>
    </div>
</body>
</html>