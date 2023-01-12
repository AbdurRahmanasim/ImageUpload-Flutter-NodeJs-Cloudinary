const express = require("express");
const router = express.Router();
const multer = require("multer");
const fs = require("fs");
const model = require("../models/imageModel");
const cloudinary = require("../cloudinary");



const upload = multer({
    storage : multer.diskStorage({
        destination : function(req , file , cb){
            cb(null , "uploads")
        } ,
        filename : function(req , file , cb){
            cb(null , file.fieldname + "-" + Date.now() + ".jpg")
       
        }
    })
})







// const registerController = require("../controller/imgController");

router.post("/uploadimage",  upload.single("user_file") ,  async(req ,res)  => {
      
   console.log(req.file.filename); 
   console.log(req.body.name);


   const result = await cloudinary.uploader.upload(req.file.path , {
    public_id : req.file.filename ,
    width : 500 ,
    height : 500 ,
    crop : "fill"
})

   model.create(  {
    user_name : req.body.name ,
    user_college : req.body.college ,
    user_age : req.body.age ,
    img : result.url
    // img : {
    //     data : fs.readFileSync("uploads/" + req.file.filename),
    //     contentType : "image/jpg"
    // } ,

   } , async (err, data ) => {

                if (err) {

                    res.send(err);

                } else {

   
 console.log(result);
                    console.log(data)


                  
                    // res.json({ "message": "User Successfully Registered." });
                    
                }
            });
   
    // res.json({"message" : "success"}) ;

});


router.get("/getimage", async (req, res) => {
 
    try{
      var ImageData = await model.find({}) ;
     
//    var images ={ data : fs.readFileSync("uploads/user_file-1673437473430.jpg")};
      res.send(ImageData);
      console.log("Success");
  
  } catch (err) {
  
      res.json({"ERROR": "Images Not Found"});
  
  }
  
  });







module.exports = router;