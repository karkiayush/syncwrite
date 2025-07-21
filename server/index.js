const express = require("express")
const mongoose = require("mongoose")
const cors = require('cors')
const authRouter = require("./routes/auth")
const documentRouter = require("./routes/document")

const PORT = process.env.PORT | 3001
const app = express()


/* middleware */
app.use(cors());
app.use(express.json())
app.use(authRouter)
app.use(documentRouter)

const DB = "mongodb+srv://karkiayush619:AZ9IZsNX4UE5ocz6@cluster0.cams5md.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

/* DB Connection logic */
mongoose.connect(DB).then(() => {
    console.log("Connection Successful!!");
}).catch((err) => {
    console.log("Error");
})

/* server is listening */
app.listen(
    PORT,
    "0.0.0.0",
    () => {
        console.log(`Connected at port ${PORT}`);
    }
)