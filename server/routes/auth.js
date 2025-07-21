const express = require("express");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, profilePic } = req.body;

        /*check if the same email already exists or not, if yes reject that or is not registered, store that data*/
        let user = await User.findOne({ email: email })
        if (!user) {
            user = new User({
                email: email,
                profilePic: profilePic,
                name: name
            })

            /* saving user data to the mongodb */
            user = await user.save()
        }
        /* JWT logic where the server sends jwt token to the client */
        const token = jwt.sign({ id: user._id }, "passwordKey");
        return res.json({ user: user, token });
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})


/* "auth" is a validator that validates the user authenticity like: whether user is loged in or not, tokens are valid or not & so on.. */
authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ user, token: req.token });
});


module.exports = authRouter