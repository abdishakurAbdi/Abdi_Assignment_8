//dependencies
const { application, response } = require('express');
const express = require('express');
const app = express();
app.use(express.json());
const nodemon = require('nodemon');

//MongoDB
const mongoose = require('mongoose');
const PORT = 1200;
const dbURL = "mongodb+srv://admin:XZ233LH7RhJJTvB@cluster0.t0xmx.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
//Connect to DB
mongoose.connect(dbURL,
    {
        useNewUrlParser: true,
        useUnifiedTopology: true
    }
);

//This is the MongoDB Connection
const db = mongoose.connection;
//Handle error/Display connection
db.on('error', () => {
    console.error.bind(console, 'connection error: ');
});
db.once('open', () => {
    console.log('MongoDB Connected');
});

//Set up Models
require('./Models/Course');
require('./Models/Student');
const Course = mongoose.model("COURSE");
const Student = mongoose.model("STUDENT");

//the below route can be used to make sure that postman is working. 
//To use: uncomment the section, and send a get request on localhost:1200/ and you will get the json body returned.
// app.get('/', (req, res) => {
//     return res.status(200).json("{message:'ok'}")
// });


//Below are the routes. Please pick one to work on and document.

//getAllCourses Route written by Tasha Denson-Byers
//After connecting to the server/API, to 'GET' all
//courses listed in the database, the await keyword works
//inside the async function to execute the action of finding
//all the records in courses using the empty 'find' function.
//The 'lean' function makes the process fast and easier on memory.
//Once the code executes, a response code of 200 is returned along
//with a listing of all of the 'courses' housed in the database.
app.get('/getAllCourses', async (req, res) => {
    try {
        let courses = await Course.find({}).lean();
        return res.status(200).json({"courses": courses});
    }
    catch {
        return res.status(500);
    }
});

//ROUTENAME written by Abdishakur Abdi
/*
    this route gets all the stuednts information and then
    displays it as JSON format.
*/
app.get('/getAllStudents', async (req, res) => {
    try {
        let students = await Student.find({}).lean();
        return res.status(200).json({"students": students})

    }
    catch {
        return res.status(500);
    }
});

//ROUTENAME written by Jax Pelzer
/*
    This is a get route that will find a student with first name 
    that is given and the display all other data on that student

*/
app.get('/findStudent', async (req, res) => {
    try {
        let student = await Student.find({ fname: req.body.fname })

        return res.status(200).json({student})
    }
    catch {
        return res.status(500);
    }
});

//findCourse written by Kevin
/*
    This route waits for user to insert a courseID in JSON format
     into the body like so:
     {
    "courseID":""
     }
     will return information about queried course.
*/
app.get('/findCourse', async (req, res) => {
    try {
        let course = await Course.find({ courseID: req.body.courseID })

        return res.status(200).json(course);
    }
    catch {
        return res.status(500);
    }
});

//addCourse written by Martin Schendel
//To add a course: 
//  send a POST request on localhost:1200/addCourse
//  body must be JSON that provides:
//  {"courseInstructor": "",
//  "courseCredits": #,
//  "courseID": "",
//  "courseName": "",
app.post('/addCourse', async (req, res) => {
    try {
        let course = {
            courseInstructor: req.body.courseInstructor,
            courseCredits: req.body.courseCredits,
            courseID: req.body.courseID,
            courseName: req.body.courseName
        }
        await Course(course).save().then(() => {
            return res.status(201).json("Course Added.");
        });
    }
    catch {
        return res.status(500);
    }
});

//ROUTENAME written by Coy Bailey
//This route allows the client to add a student to the database using the POST request
app.post('/addStudent', async (req, res) => {
    try {
        let student = {
            fname: req.body.fname,
            lname: req.body.lname,
            studentID: req.body.studentID
        }
        await Student(student).save().then(() => {
            return res.status(201).json("Student Added.");
        });
    }
    catch {
        return res.status(500);
    }
});

// This route allows the client to edit and update a student to the database using the POST request
app.post('/editStudentById', async (req, res) => {
    try {
        let student = await Student.updateOne({_id: req.body.id},
            {
                fname: req.body.fname
            }, {upsert: true})

        if(student){
            res.status(201).json("Student Updated."); 
        }
        else{
            res.status(200).json("Student Not Found.");
        }
    }
    catch {
        return res.status(500);
    }
});

// This route allows the client to edit and update a student to the database using the POST request
app.post('/editStudentByFname', async (req, res) => {
    try {
        let student = await Student.findOne({fname: req.body.queryname},
            {
                fname: req.body.fname,
                lname: req.body.lname
            }, {upsert: true})

        if(student){
            res.status(201).json("Student Updated."); 
        }
        else{
            res.status(200).json("Student Not Found.");
        }
    }
    catch {
        return res.status(500);
    }
});

// This route allows the client to edit and update course to the database using the POST request
app.post('/editCourseByCourseName', async (req, res) => {
    try {
        let student = await Course.updateOne({courseName: req.body.courseName}
            ,{
                courseInstructor: req.body.courseInstructor
            }, {upsert: true})

        if(student){
            res.status(201).json("Course Instructor Updated."); 
        }
        else{
            res.status(200).json("Course Not Found.");
        }
    }
    catch {
        return res.status(500);
    }
});

// This route allows the client to delete a course from the database using the POST request
app.post('/deleteCourseById', async (req, res) => {
    try {
        let course = await Course.findOne({_id: req.body.id})

        if(course){
            await Course.deleteOne({_id: req.body.id})
            res.status(201).json("Course Deleted."); 
        }
        else{
            res.status(200).json("Course Not Found.");
        }
    }
    catch {
        return res.status(500);
    }
});

// This route allows the client to delete a student from the database using the POST request
app.post('/removeStudentById', async (req, res) => {
    try {
        let student = await Student.findOne({_id: req.body.id})

        if(student){
            await Student.deleteOne({_id: req.body.id})
            res.status(201).json("Student Removed."); 
        }
        else{
            res.status(200).json("Student Not Found.");
        }
    }
    catch {
        return res.status(500);
    }
});


//Start the Server
app.listen(PORT, () => {
    console.log(`API for Group 1 now running on port ${PORT}`)
});
