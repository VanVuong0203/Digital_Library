import { useEffect, useState } from 'react';
import '../assets/styles/AdminSlider.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faArrowUp, faXmark } from '@fortawesome/free-solid-svg-icons';
import { fetchSlider, updateSlider } from '../services/api';

const AdminSlider = () => {
    const [sliderData, setSliderData] = useState([]);
    const [fakeData, setFakeData] = useState([]);
    useEffect(() => {
        fetchSlider().then((res) => {
            setSliderData(res.data[0]);
        })
    }, [])

    // Convert input sang base 64
    const uploadImage = async (e, name) => {
        const file = e.target.files[0];
        const base64 = await convertBase64(file);

        setSliderData({ ...sliderData, [name]: file });
        setFakeData({ ...fakeData, [name]: base64 })

    };
    console.log(fakeData);
    console.log(sliderData);

    const convertBase64 = (file) => {
        return new Promise((resolve, reject) => {
            const fileReader = new FileReader();
            fileReader.readAsDataURL(file);

            fileReader.onload = () => {
                resolve(fileReader.result);
            };

            fileReader.onerror = (error) => {
                reject(error);
            };
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {

            const formData = new FormData();
            console.log(sliderData);
            let i = 1;
            for (i; i <= 4; i++) {
                formData.append(`img${i}`, sliderData[`img${i}`]);

            }

            const res = await updateSlider(formData);
            if (res.ok) {
                alert("đã cập nhật thành công!")
            }
        } catch (error) {

        }
    };

    const handleDeleteImg = (name) => {
        const confirmDelete = window.confirm("Bạn có chắc muốn xóa slider này không?");
        if (confirmDelete) {
            setSliderData({ ...sliderData, [name]: "" });
            setFakeData({ ...fakeData, [name]: "" });
        }
    };

    return (
        <>
            <div className={"slider_container"}>
                <div className={'inner'}>
                    <h2 className={'heading'}>Chỉnh Sửa Slider</h2>
                </div>
                <div className={'wrapper_img'}>
                    <form className={'inner_img'} onSubmit={handleSubmit}>
                        <div className={'upload_box'}>
                            <div className={'file_upload'}>
                                <input
                                    type="file"
                                    className={'upload'}
                                    disabled={fakeData.img1 ? fakeData.img1 : sliderData.img1}
                                    onChange={(e) => uploadImage(e, "img1")}
                                />
                                <FontAwesomeIcon
                                    icon={faArrowUp}
                                    className={`${fakeData.img1 || sliderData.img1 ? "fadeout" : ""}`}
                                />
                                <div className={`img_box ${fakeData.img1 || sliderData.img1 ? "fadein" : ""}`}>
                                    <img alt="Slider 01" className={'img'} src={fakeData.img1 ? fakeData.img1 : sliderData.img1}
                                    />
                                    <div className={`delete_box ${fakeData.img1 || sliderData.img1 ? "active" : ""}`}>
                                        <FontAwesomeIcon
                                            icon={faXmark}
                                            className={'btn_delete'}
                                            onClick={(e) => handleDeleteImg("img1")}
                                        />
                                    </div>
                                </div>
                            </div>
                            <div className={'file_upload'}>
                                <input
                                    type="file"
                                    className={'upload'}
                                    disabled={fakeData.img2 ? fakeData.img2 : sliderData.img2}
                                    onChange={(e) => uploadImage(e, "img2")}
                                />
                                <FontAwesomeIcon
                                    icon={faArrowUp}
                                    className={`${fakeData.img2 || sliderData.img2 ? "fadeout" : ""}`}
                                />
                                <div className={`img_box ${fakeData.img2 || sliderData.img2 ? "fadein" : ""}`}>
                                    <img alt="Slider 02" className={'img'} src={fakeData.img2 ? fakeData.img2 : sliderData.img2}
                                    />
                                    <div className={`delete_box ${fakeData.img2 || sliderData.img2 ? "active" : ""}`}>
                                        <FontAwesomeIcon
                                            icon={faXmark}
                                            className={'btn_delete'}
                                            onClick={(e) => handleDeleteImg("img2")}
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className={'upload_box'}>
                            <div className={'file_upload'}>
                                <input
                                    type="file"
                                    className={'upload'}
                                    disabled={fakeData.img3 ? fakeData.img3 : sliderData.img3}
                                    onChange={(e) => uploadImage(e, "img3")}
                                />
                                <FontAwesomeIcon
                                    icon={faArrowUp}
                                    className={`${fakeData.img3 || sliderData.img3 ? "fadeout" : ""}`}
                                />
                                <div className={`img_box ${fakeData.img3 || sliderData.img3 ? "fadein" : ""}`}>
                                    <img alt="Slider 03" className={'img'} src={fakeData.img3 ? fakeData.img3 : sliderData.img3}
                                    />
                                    <div className={`delete_box ${fakeData.img3 || sliderData.img3 ? "active" : ""}`}>
                                        <FontAwesomeIcon
                                            icon={faXmark}
                                            className={'btn_delete'}
                                            onClick={(e) => handleDeleteImg("img3")}
                                        />
                                    </div>
                                </div>
                            </div>
                            <div className={'file_upload'}>
                                <input
                                    type="file"
                                    className={'upload'}
                                    disabled={fakeData.img4 ? fakeData.img4 : sliderData.img4}
                                    onChange={(e) => uploadImage(e, "img4")}
                                />
                                <FontAwesomeIcon
                                    icon={faArrowUp}
                                    className={`${fakeData.img4 || sliderData.img4 ? "fadeout" : ""}`}
                                />
                                <div className={`img_box ${fakeData.img4 || sliderData.img4 ? "fadein" : ""}`}>
                                    <img alt="Slider 04" className={'img'} src={fakeData.img4 ? fakeData.img4 : sliderData.img4}
                                    />
                                    <div className={`delete_box ${fakeData.img4 || sliderData.img4 ? "active" : ""}`}>
                                        <FontAwesomeIcon
                                            icon={faXmark}
                                            className={'btn_delete'}
                                            onClick={(e) => handleDeleteImg("img4")}
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button className={'btn_update'}
                            type='submit'
                        >
                            Update
                        </button>
                    </form>
                </div >
            </div >
        </>
    );
}

export default AdminSlider;