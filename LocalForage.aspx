<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LocalForage.aspx.cs" Inherits="LocalForage.LocalForage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="/localforage.js"></script>
    <title>Demo on Local Forage</title>
    
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>Set the Values to Local Forage</td>
                    <td>:</td>
                    <td> <textarea rows="4" cols="50" id="txtSetValues"></textarea> <input type="button" id="btnSet" value="Set the values" title="Set the values" onclick="javascript: SetValue();"/></td>
                </tr>
                <tr>
                    <td>Get the Values to Local Forage</td>
                    <td>:</td>
                    <td><input type="button" id="btnGet" value="Get the values" onclick="javascript: GetValue(); multipleInstances();" title="Get the values"/></td>
                </tr>
            </table>
        </div>
    </form>
</body>
    <script>
        //************* set the value *********************
        function SetValue() {
            localforage.setItem('PushValue', '' + document.getElementById("txtSetValues").value + '').then(function (value) {
                console.log(value);
                alert("set the value to 'PushValue' array : " + value);
            }).catch(function (err) {
                console.log(err);
            });
        }
        //************* get the value *********************
        function GetValue() {
            localforage.getItem('PushValue').then(function (value) {
                console.log(value);
                alert("Get the value from 'PushValue' array : " + value);
            }).catch(function (err) {
                console.log(err);
                });
           
        }
        //********************************************************************
        req = new XMLHttpRequest();
        req.open('GET', '/photo.jpg', true);
        req.responseType = 'arraybuffer';
        req.addEventListener('readystatechange', function ()
        {
            if (req.readyState === 4)
            { // readyState DONE
                debugger
                localforage.setItem('photo', req.response).then(function (image)
                {
                    debugger                    
                    var blob = new Blob([image]);
                    var imageURI = window.URL.createObjectURL(blob);
                    alert(imageURI);
                }).catch(function (err)
                {
                    debugger                    
                    console.log(err);
                });
            }
        });

        function multipleInstances() {
            var store = localforage.createInstance({
                name: "First Instance"
            });

            var otherStore = localforage.createInstance({
                name: "Second Instance"
            });

            // Setting the key on one of these doesn't affect the other.
            store.setItem("key", "First Instance");
            otherStore.setItem("key", "Second Instance");
            store.setItem("key", "First Instance").then(function (value) {
                console.log(value);
                alert("Get the value from 'store key' array : " + value);
            }).catch(function (err) {
                console.log(err);
                });

            otherStore.setItem("key", "Second Instance").then(function (value) {
                console.log(value);
                alert("Get the value from 'otherStore key' array : " + value);
            }).catch(function (err) {
                console.log(err);
            });
        }
    </script>
</html>
