const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Book = sequelize.define("Book", {
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
        allowNull: false,
    },
    genre: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    description: {
        type: DataTypes.TEXT,
    },
    published_year: {
        type: DataTypes.INTEGER,
    },
    imgs: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    content_path: {
        type: DataTypes.TEXT,

    }
}, {
    timestamps: false,
    tableName: "books"
});

module.exports = Book;
