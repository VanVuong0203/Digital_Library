const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const Book = require("../models/Book");

const BookView = sequelize.define("book_views", {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    book_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    view_count: {
        type: DataTypes.INTEGER,
        defaultValue: 0,
    },
    read_count: {
        type: DataTypes.INTEGER,
        defaultValue: 0,
    },
}, {
    timestamps: false,
    tableName: "book_views",
});

BookView.belongsTo(Book, {
    foreignKey: 'book_id',
    targetKey: 'id',
});

module.exports = BookView;
