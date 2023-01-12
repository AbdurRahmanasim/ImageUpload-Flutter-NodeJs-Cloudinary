const express = require("express")
const app = express() 
const PORT = process.env.PORT || 1212 ;
const mongoose = require("mongoose")
const cors = require("cors")
const routes = require("./routes/routes")
// const model = require("./model/registerschema")

mongoose.set('strictQuery', true) ;


app.use(express.json())
app.use(cors())
app.use(express.urlencoded({ extended: true }));
app.use(routes);
 
mongoose.connect("mongodb+srv://admin:admin@cluster0.tizqsty.mongodb.net/?retryWrites=true&w=majority",{
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
mongoose.connection.on('connected',()=>{
    console.log('Mongo DB connected')
})
mongoose.connection.on('error',(err)=>{
    console.log('error',err)
})

app.listen(PORT , ()=>{
    console.log(`server is listening on ${PORT}`)
})