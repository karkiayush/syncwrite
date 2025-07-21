/* Document model should have:
1. user id
2. created at
3. title
4. contents
*/

const mongoose = require("mongoose");

const documentSchema = mongoose.Schema({
    uid: {
        required: true,
        type: String,
    },
    createdAt: {
        required: true,
        type: Number,
    },
    title: {
        required: true,
        type: String,
        trim: true,
    },
    content: {
        type: Array,
        default: [],
    },
});

const Document = mongoose.model("Document", documentSchema);

module.exports = Document;