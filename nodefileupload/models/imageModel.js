
const mongoose = require("mongoose");

const registerSchema = new mongoose.Schema({
    
user_name :
{
    type : String ,
},
user_college :
{
    type : String ,
},
user_age :
{
    type : String ,
},
    img:
    {
        type : String 

    }


   

});

const UserModel = mongoose.model("imagesFlutter", registerSchema);

module.exports = UserModel;