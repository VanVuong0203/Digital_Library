const bcrypt = require("bcryptjs");

(async () => {
    const hashedPassword = await bcrypt.hash("123456", 10);
    console.log("Mật khẩu đã mã hóa:", hashedPassword);
})();