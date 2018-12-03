//Initiallising node modules
var express = require("express");
var bodyParser = require("body-parser");
var sql = require("mssql");
var app = express();

// Body Parser Middleware
//app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));


//CORS Middleware
app.use(function (req, res, next) {
    //Enabling CORS
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, contentType,Content-Type, Accept, Authorization");
    next();
});

//Setting up server
 var server = app.listen(process.env.PORT || 5000, function () {
    var port = server.address().port;
    console.log("App now running on port", port);
 });

//Initiallising connection string
var dbConfig = {
    user:  "ecto-dev",
    password: "admin",
    server: "WIN-GJKJJAHU6O",
    database:"ecto-dev",
    options: {
		encrypt: false
    }
};

//Function to connect to database and execute query
var  executeQuery = function(res, query){
	sql.connect(dbConfig, function (err) {
		if (err) {
			console.log("Error while connecting database :- " + err);
			res.send(err);
		}
		else {
			// create Request object
			var request = new sql.Request();
			// query to the database
			request.query(query, function (err, responsePacket) {
				if (err) {
					console.log("Error while querying database :- " + err);
					res.send(err);
					sql.close();
				}
				else {
					res.send(responsePacket);
					sql.close();
				}
			});
		}
	});
}

//GET API
app.get("/api/events", function(req , res){
	var query = "SELECT * FROM Event WHERE IsDeleted = 0 AND IsActive = 1";
    executeQuery (res, query);
});

//GET API
app.get("/api/event", function(req , res){
	console.log(req.query);
	var query = "SELECT * FROM Event WHERE publishdate = '"+req.query.publishdate+"' AND radius <= "+req.query.radius+" AND IsDeleted = 0 AND IsActive = 1";
    executeQuery (res, query);
});

//POST API
app.post("/api/event", function(req , res){
	var query = "INSERT INTO Event (DisplayName,Latitude,Longitude,Radius,PublishDate,IsActive,IsDeleted) VALUES ('"+req.body.displayname+"',"+req.body.latitude+","+req.body.longitude+","+req.body.radius+",'"+req.body.publishdate+"',1,0)";
    executeQuery (res, query);
});

//PUT API
app.put("/api/event/:id", function(req , res){
	var query = "UPDATE Event SET PublishDate= " + req.body.publishdate  +  " , Radius=  " + req.body.radius + ", Latitude=  " + req.body.latitude + ", Logitude=  " + req.body.longitude + " WHERE Id= " + req.params.id;
    executeQuery (res, query);
});

// DELETE API
app.delete("/api/event/:id", function(req , res){
	var query = "UPDATE Event SET IsDeleted= 1 WHERE EventId = " + req.params.id;
	executeQuery (res, query);
});