const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const slider = sequelize.define("slider", {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
    },
    img1: {
        type: DataTypes.TEXT,
    },
    img2: {
        type: DataTypes.TEXT,
    },
    img3: {
        type: DataTypes.TEXT,
    },
    img4: {
        type: DataTypes.TEXT,
    }
}, {
    timestamps: false,
    tableName: "slider",
});

module.exports = slider;
