// models/AudioBook.js
const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const AudioBook = sequelize.define("AudioBook", {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    title: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    author: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    audio_url: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    cover_image: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    description: {
        type: DataTypes.TEXT,
        allowNull: true,
    }
}, {
    timestamps: false,
    tableName: "audio_books"
});

module.exports = AudioBook;
