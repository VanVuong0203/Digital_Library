--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-06-06 10:10:56

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4971 (class 1262 OID 16388)
-- Name: book_library; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE book_library WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en-US';


ALTER DATABASE book_library OWNER TO postgres;

\connect book_library

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 876 (class 1247 OID 16449)
-- Name: enum_users_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_role AS ENUM (
    'user',
    'admin'
);


ALTER TYPE public.enum_users_role OWNER TO postgres;

--
-- TOC entry 873 (class 1247 OID 16443)
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'user',
    'admin'
);


ALTER TYPE public.user_role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 16578)
-- Name: audio_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audio_books (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(255),
    audio_url character varying(255) NOT NULL,
    cover_image character varying(255),
    description text
);


ALTER TABLE public.audio_books OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16577)
-- Name: audio_books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audio_books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audio_books_id_seq OWNER TO postgres;

--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 227
-- Name: audio_books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audio_books_id_seq OWNED BY public.audio_books.id;


--
-- TOC entry 226 (class 1259 OID 16535)
-- Name: book_views; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_views (
    id integer NOT NULL,
    book_id integer NOT NULL,
    view_count integer DEFAULT 1,
    read_count integer DEFAULT 1
);


ALTER TABLE public.book_views OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16534)
-- Name: book_views_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_views_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_views_id_seq OWNER TO postgres;

--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 225
-- Name: book_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_views_id_seq OWNED BY public.book_views.id;


--
-- TOC entry 219 (class 1259 OID 16414)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    genre character varying(100) NOT NULL,
    description text,
    published_year bigint,
    imgs character varying(255),
    content_path character varying(255)
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16413)
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO postgres;

--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 218
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- TOC entry 223 (class 1259 OID 16474)
-- Name: rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating (
    id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    name character varying(100),
    title character varying(255),
    comment text,
    rating integer,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT rating_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.rating OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16473)
-- Name: rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rating_id_seq OWNER TO postgres;

--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 222
-- Name: rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rating_id_seq OWNED BY public.rating.id;


--
-- TOC entry 224 (class 1259 OID 16497)
-- Name: slider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.slider (
    id integer NOT NULL,
    img1 text,
    img2 text,
    img3 text,
    img4 text
);


ALTER TABLE public.slider OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16432)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role public.user_role DEFAULT 'user'::public.user_role
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16431)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4791 (class 2604 OID 16581)
-- Name: audio_books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audio_books ALTER COLUMN id SET DEFAULT nextval('public.audio_books_id_seq'::regclass);


--
-- TOC entry 4788 (class 2604 OID 16538)
-- Name: book_views id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_views ALTER COLUMN id SET DEFAULT nextval('public.book_views_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 16459)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- TOC entry 4786 (class 2604 OID 16477)
-- Name: rating id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating ALTER COLUMN id SET DEFAULT nextval('public.rating_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 16435)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4965 (class 0 OID 16578)
-- Dependencies: 228
-- Data for Name: audio_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.audio_books VALUES (3, 'Hai Đứa Trẻ Audio | Bản Full', 'Thạch Lam', 'https://ia802307.us.archive.org/18/items/hai-dua/hai-dua.mp3', 'https://i0.wp.com/sachnoiviet.net/wp-content/uploads/2021/11/hai-dua-tre.jpg?fit=200%2C300&ssl=1', 'Hai đứa trẻ xoay quanh số phận những con người nơi phố huyện nghèo qua lời kể của nhân vật Liên. Liên và An sống tại một phố huyện nghèo, được mẹ giao nhiệm vụ trông coi một cửa hàng tạp hóa nhỏ. Trước đây gia đình Liên sống ở Hà Nội, nhưng bố bị mất việc nên phải chuyển về quê sống. Mẹ con chị Tí bán hàng nước , gánh phở của Bác Siêu, sập hát của bác Xẩm… đều là những kiếp người nhỏ bé, nghèo khổ nơi phố huyện nghèo. Liên cũng như bao người dân sống ở đây, ngày ngày họ đều trông ngóng để được ngắm chuyến tàu chạy qua phố huyện. Hình ảnh chuyến tàu ấy đi qua mang theo những âm thanh và ánh sáng gợi lên trong nhân vật Liên những ngày ở Hà Nội và những khát vọng về một cuộc sống tốt đẹp hơn');
INSERT INTO public.audio_books VALUES (4, 'Không Diệt Không Sinh Đừng Sợ Hãi', 'Thích Nhất Hạnh', 'http://dn721808.ca.archive.org/0/items/khong-diet-1/khong-diet-1.mp3', 'https://i0.wp.com/sachnoiviet.net/wp-content/uploads/2021/11/khong-diet-khong-sinh-dung-so-hai.jpg?fit=200%2C300&ssl=1', 'Không diệt Không sinh Đừng sợ hãi là tựa sách được Thiền sư Thích Nhất Hạnh viết nên dựa trên kinh nghiệm của chính mình. Ở đó, Thầy Nhất Hạnh đã đưa ra một thay thế đáng ngạc nhiên cho hai triết lý trái ngược nhau về vĩnh cửu và hư không: “Tự muôn đời tôi vẫn tự do. Tử sinh chỉ là cửa ngõ ra vào, tử sinh là trò chơi cút bắt. Tôi chưa bao giờ từng sinh cũng chưa bao giờ từng diệt” và “Nỗi khổ lớn nhất của chúng ta là ý niệm về đến-đi, lui-tới.”

Được lặp đi lặp lại nhiều lần, Thầy khuyên chúng ta thực tập nhìn sâu để chúng ta hiểu được và tự mình nếm được sự tự do của con đường chính giữa, không bị kẹt vào cả hai ý niệm của vĩnh cửu và hư không. Là một thi sĩ nên khi giải thích về các sự trái ngược trong đời sống, Thầy đã nhẹ nhàng vén bức màn vô minh ảo tưởng dùm chúng ta, cho phép chúng ta (có lẽ lần đầu tiên trong đời) được biết rằng sự kinh hoàng về cái chết chỉ có nguyên nhân là các ý niệm và hiểu biết sai lầm của chính mình mà thôi…');
INSERT INTO public.audio_books VALUES (5, 'Chú Bé Có Tài Mở Khóa', 'Nguyễn Quang Thân', 'https://ia801503.us.archive.org/2/items/chu-be-co-tai-mo-khoa-01/CHU_BE_CO_TAI_MO_KHOA_01.mp3', 'https://i0.wp.com/sachnoiviet.net/wp-content/uploads/2022/06/chu-be-co-tai-mo-khoa.jpg?fit=200%2C300&ssl=1', '
Phần 1

00:00
Phần 1
Phần 2
Phần 3
Phần 4
Phần 5
Phần Cuối
Chú Bé Có Tài Mở Khóa là một truyện phiêu lưu, kể về chú bé Hùng bị ném ra ngoài xã hội, phải đối mặt với cái xấu, cái ác, phải vật lộn nhọc nhằn, gặp đủ loại người tốt có, xấu có, có khi được cưu mang, có lúc bị vùi dập… Truyện  hấp dẫn ở những tình huống bất ngờ, nhiều chi tiết gay cấn, hồi hộp và nhiều chi tiết gây xúc động với bạn đọc… Tác phẩm từng được giải thưởng chính thức về văn học thiếu nhi do Hội Nhà văn trao năm 1995.');
INSERT INTO public.audio_books VALUES (6, 'Harry Potter 4: Chiếc Cốc Lửa', 'J. K. Rowling', 'https://dn720302.ca.archive.org/0/items/harry-tap-bon-01/harry-tap-bon-01.mp3', 'https://i0.wp.com/sachnoiviet.net/wp-content/uploads/2021/11/harry-potter-va-chiec-coc-lua-tap-4.jpg?fit=200%2C300&ssl=1', 'Harry Potter và chiếc cốc lửa là câu chuyện về năm thứ tư của Harry Potter tại Hogwarts. Đây là bộ truyện mà cô J.K. Rowling tâm đắc nhất trong 7 tập. Harry Potter 14 tuổi, cùng gia đình Weasley tham dự Cúp Quidditch thế giới, nơi diễn ra một hiện tượng kỳ bí làm cho mọi người đều run sợ. Rồi cậu bước vào năm thứ tư ở trường Hogwarts, với cuộc thi Tam Pháp Thuật đầy thử thách, cùng với các nhà phù thủy thiếu niên tài năng trên thế giới. Năm nay cậu lại có một giáo sư mới cho môn Phòng chống nghệ thuật hắc ám – Moody Mắt Điên…');
INSERT INTO public.audio_books VALUES (7, 'Đức Phật Bên Trong', 'Nguyễn Duy Nhiên', 'https://ia600406.us.archive.org/14/items/duc-phat-1/duc-phat-1.mp3', 'https://i0.wp.com/sachnoiviet.net/wp-content/uploads/2022/03/duc-phat-ben-trong.jpg?fit=200%2C300&ssl=1', 'Đức Phật Bên Trong được dịch giả Nguyễn Duy Nhiên sau nhiều năm tự mình thực hành con đường tu tập đóng góp rất nhiều  trong việc chuyển dịch các tác phẩm nổi tiếng của những bậc thầy ngoài nước sang Việt ngữ và được rất nhiều người quan tâm đến Phật Giáo biết đến. Anh cũng đã dày công sưu tập các bài viết hay và đưa vào tuyển tập này, cung cấp cho người đọc một cái nhìn khá toàn diện về sự tu tập trong cuộc sống thường ngày.');
INSERT INTO public.audio_books VALUES (1, 'Đắc Nhân Tâm - Phần 1', 'Dale Carnegie', 'https://dn720304.ca.archive.org/0/items/dac-nhan/dac-nhan.mp3', 'https://nhasachphuongnam.com/images/detailed/217/dac-nhan-tam-bc.jpg', 'Một cuốn sách nổi tiếng giúp bạn hiểu rõ cách giao tiếp và tạo dựng mối quan hệ tốt đẹp.');
INSERT INTO public.audio_books VALUES (2, 'Nhà Giả Kim - Phần 1', 'Paulo Coelho', 'https://ia804602.us.archive.org/4/items/nha-gia-1/nha-gia-1.mp3', 'https://dtv-ebook.com.vn/images/truyen-online/ebook-nha-gia-kim-prc-pdf-epub.jpg', 'Một cuốn sách triết lý, nói về hành trình của một cậu bé chăn cừu trong cuộc tìm kiếm kho báu của mình.');
INSERT INTO public.audio_books VALUES (8, 'Con Đường Giác Ngộ', 'Thích Thông Phương', 'https://ia801805.us.archive.org/30/items/con-duong-03/con-duong-01.mp3', 'https://i0.wp.com/sachnoiviet.net/wp-content/uploads/2022/01/con-duong-giac-ngo.jpg?fit=200%2C300&ssl=1', 'Con đường giác ngộ là tập sách được ghi lại từ những bài giảng, mong rằng sẽ đem lại một chút ánh sáng trên đường giác ngộ cho người trở về quê Giác. Tuy nhiên, con đường giác ngộ chân thật vốn không nằm trên những chữ nghĩa chết này, mà ở ngay trong tâm của mỗi người. Do đó, để có được những bước đi chắc thật, người học Phật phải là những hành giả thực sự, chớ không thể chỉ tự hài lòng trên kiến thức văn tự. Những dòng chữ này không thể ghi lại ánh sáng giác ngộ chân thật.');
INSERT INTO public.audio_books VALUES (9, 'Muốn An Được An', 'Thích Nhất Hạnh', 'https://dn720303.ca.archive.org/0/items/muon-an-1/muon-an-1.mp3', 'https://i0.wp.com/sachnoiviet.net/wp-content/uploads/2021/11/muon-an-duoc-an.jpg?fit=200%2C300&ssl=1', 'Muốn an được an được Thiền sư Thích Nhất Hạnh viết bằng tiếng Anh với tên gọi Being Peace. Tác phẩm xuất bản bản tiếng Anh lần đầu năm 1987, tới nay được đánh giá là một tác phẩm mẫu mực của văn học tôn giáo đương đại. Tác phẩm được sư cô Chân Hội Nghiêm chuyển sang tiếng Việt trong lần phát hành đầu tiên tại Việt Nam.

Trong “Muốn an được an” Thiền sư Thích Nhất Hạnh đưa ra các con số về tình hình xã hội ở thời điểm tác giả viết sách: “Mỗi ngày có 40.000 trẻ em chết đói. Những siêu cường quốc có hơn 50.000 đầu đạn hạt nhân, đủ để tiêu diệt hành tinh của chúng ta nhiều lần”. Theo Thiền sư, cuộc sống có nhiều khổ đau như vậy, nhưng cũng tràn đầy mầu nhiệm: “Tuy nhiên, mặt trời mọc sáng nay rất đẹp, những đóa hoa hồng nở ven đường sáng nay là một màu nhiệm”.');


--
-- TOC entry 4963 (class 0 OID 16535)
-- Dependencies: 226
-- Data for Name: book_views; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.book_views VALUES (21, 155, 4, 42);
INSERT INTO public.book_views VALUES (7, 141, 11, 18);
INSERT INTO public.book_views VALUES (12, 147, 2, 10);
INSERT INTO public.book_views VALUES (1, 140, 44, 125);
INSERT INTO public.book_views VALUES (17, 7, 3, 11);
INSERT INTO public.book_views VALUES (31, 165, 5, 0);
INSERT INTO public.book_views VALUES (22, 159, 5, 21);
INSERT INTO public.book_views VALUES (5, 143, 17, 99);
INSERT INTO public.book_views VALUES (16, 152, 9, 42);
INSERT INTO public.book_views VALUES (9, 43, 4, 22);
INSERT INTO public.book_views VALUES (32, 156, 4, 0);
INSERT INTO public.book_views VALUES (2, 9, 17, 13);
INSERT INTO public.book_views VALUES (26, 158, 4, 1);
INSERT INTO public.book_views VALUES (29, 167, 41, 0);
INSERT INTO public.book_views VALUES (28, 163, 4, 0);
INSERT INTO public.book_views VALUES (33, 162, 1, 0);
INSERT INTO public.book_views VALUES (34, 164, 2, 0);
INSERT INTO public.book_views VALUES (3, 4, 6, 46);
INSERT INTO public.book_views VALUES (23, 160, 5, 53);
INSERT INTO public.book_views VALUES (18, 47, 5, 35);
INSERT INTO public.book_views VALUES (15, 48, 13, 78);
INSERT INTO public.book_views VALUES (27, 3, 2, 1);
INSERT INTO public.book_views VALUES (10, 145, 4, 67);
INSERT INTO public.book_views VALUES (14, 150, 7, 101);
INSERT INTO public.book_views VALUES (20, 154, 2, 76);
INSERT INTO public.book_views VALUES (8, 144, 11, 123);
INSERT INTO public.book_views VALUES (36, 169, 18, 2);
INSERT INTO public.book_views VALUES (38, 171, 20, 1);
INSERT INTO public.book_views VALUES (13, 151, 13, 3);
INSERT INTO public.book_views VALUES (37, 168, 10, 1);
INSERT INTO public.book_views VALUES (11, 149, 31, 23);
INSERT INTO public.book_views VALUES (24, 40, 2, 75);
INSERT INTO public.book_views VALUES (25, 50, 2, 55);
INSERT INTO public.book_views VALUES (19, 42, 17, 31);
INSERT INTO public.book_views VALUES (6, 44, 56, 38);
INSERT INTO public.book_views VALUES (4, 142, 30, 11);
INSERT INTO public.book_views VALUES (30, 166, 4, 0);
INSERT INTO public.book_views VALUES (35, 170, 30, 2);


--
-- TOC entry 4956 (class 0 OID 16414)
-- Dependencies: 219
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.books VALUES (142, 'Bán Hàng Cho Những Gã Khổng Lồ', 'Jill Konrath', 'Kinh doanh & Tài chính', '“Thu Phục Khủng Bố Thị Trường: Bí Quyết Bán Hàng Cho Các Gã Đại Gia” – Jill Konrath và Cuộc Đối Đầu Vĩ Đại

Trong mê lộ của thế giới kinh doanh, cuốn sách “Bán Hàng Cho Những Gã Khổng Lồ” của Jill Konrath không chỉ đơn thuần là một tác phẩm bán hàng, mà còn là hướng dẫn sâu sắc giúp những chiến binh bán hàng trên địa trận doanh nghiệp lớn. Từ tác phẩm này, bạn sẽ khám phá những bí quyết và chiến lược bán hàng không thể bỏ lỡ, để chiến thắng những thách thức và đạt được sự thành công trong việc góp mặt tại thế giới của những gã khổng lồ.

Trang sách này không phải là chỉ là bề mặt, mà là một cảm hứng tận sâu trong từng chương. Jill Konrath đưa bạn vào cuộc hành trình của người bán hàng thông minh, một cuộc đối đầu với thực tế cay đắng và những vị khách hàng quyền lực. Đắm mình vào những câu chuyện hấp dẫn từ thực tế, bạn sẽ tìm thấy bản thân mình bước vào lĩnh vực phức tạp của việc kinh doanh với các doanh nghiệp lớn.

Bước chân vào từng phần của cuốn sách, bạn sẽ không chỉ tìm thấy những lời giảng thôi thúc, mà còn những cách tiếp cận thiết thực. Đây không phải là lý thuyết rời rạc, mà là những chiến lược hành động được thử nghiệm và chứng minh, từ việc phân tích nhu cầu của khách hàng cho đến xây dựng mối quan hệ vững chắc và thậm chí cả cách chốt đơn hàng với hiệu quả.

Cuốn sách không chỉ đơn thuần là tài liệu, mà là một lời thách thức mà bạn không thể bỏ lỡ. Từ việc đàm phán tài trợ đến cách cung cấp dịch vụ sau bán hàng, bạn sẽ tiếp xúc với những vấn đề thực tế và những bài học có giá trị.', 2012, '/images/books/Ebook-Ban-hang-cho-nhung-ga-khong-lo.jpg', '/books_content/Ban Hang Cho Nhung Ga Khong Lo - Jill Konrath.epub');
INSERT INTO public.books VALUES (143, ' Thiết lập Internet Vạn Vật Trong Doanh nghiệp', 'Maciej Kranz', 'Khoa học - Công nghệ', '“Thiết lập Internet Vạn Vật Trong Doanh nghiệp” là tác phẩm của Maciej Kranz, một danh tiếng đáng gờm trong lĩnh vực Internet Vạn Vật (IoT), hiện đang đảm nhiệm vị trí Phó Chủ tịch mảng Đổi mới Sáng tạo Chiến lược Doanh nghiệp tại Cisco Systems. Cuốn sách này ra mắt vào năm 2022 và đưa bạn vào một cuộc hành trình thú vị đến thế giới của IoT.

Cuốn sách không chỉ là một nguồn thông tin, mà còn là một cơ hội để bạn bước vào thế giới kỳ diệu của IoT và biến nó thành hiện thực trong doanh nghiệp của mình. Với 10 chương chi tiết và phong phú, cuốn sách này đưa bạn từng bước đi sâu vào những khía cạnh quan trọng của IoT, từ cơ bản đến triển khai thực tế.

Tác giả, Maciej Kranz, không chỉ là một chuyên gia IoT hàng đầu với hơn hai thập kỷ kinh nghiệm, mà còn là người bạn đồng hành tận tâm. Cách anh trình bày thông tin vô cùng dễ hiểu và thú vị, không làm bạn cảm thấy mệt mỏi.

Cuốn sách thấm đẫm sự thực tế, với nhiều ví dụ từ thế giới thực để giúp bạn thấy rõ ràng những khái niệm và nguyên tắc phức tạp của IoT. Bạn sẽ không chỉ hiểu được IoT là gì mà còn biết cách áp dụng nó trong doanh nghiệp của mình.

Nếu bạn là một nhà lãnh đạo doanh nghiệp, và bạn đang tìm kiếm cách để khai thác tiềm năng của IoT trong doanh nghiệp của mình, cuốn sách này xứng đáng được bạn tìm hiểu.

Cuốn sách mở đầu bằng việc giới thiệu IoT, nói đơn giản, đó là sự kết nối giữa hàng ngàn thiết bị thông qua Internet, tạo nên một mạng lưới mạnh mẽ và thông minh.

Tiếp theo, Maciej Kranz thảo luận về lợi ích mà IoT mang lại cho doanh nghiệp. Với sự phát triển của IoT, doanh nghiệp có thể tối ưu hóa hoạt động, tiết kiệm chi phí và phát triển sản phẩm và dịch vụ mới.

Nhưng không có thứ gì mà không đến cùng với những thách thức. Cuốn sách cũng đề cập đến những rủi ro về bảo mật và quyền riêng tư mà IoT có thể gây ra, đồng thời cung cấp cách để bạn đối mặt và giải quyết chúng.

Cuốn sách kết thúc bằng hướng dẫn cụ thể về việc triển khai IoT trong doanh nghiệp. Maciej Kranz cung cấp một khung làm việc để giúp bạn thực hiện dự án IoT của mình một cách thành công.

Cuốn sách không chỉ đơn giản là một cuốn sách, mà là một cơ hội để bạn khám phá và chinh phục thế giới mới của IoT trong doanh nghiệp. Nó không chỉ giúp bạn hiểu rõ hơn về IoT mà còn đưa bạn vào con đường của sự sáng tạo và thành công.', 2022, '/images/books/Ebook-Thiet-lap-Internet-Van-Vat-trong-doanh-nghiep.jpg', '/books_content/Thiet lap Internet Van Vat Trong Doanh nghiep - Maciej Kranz.epub');
INSERT INTO public.books VALUES (7, 'Mắt Biếc', 'Nguyễn Nhật Ánh', 'Văn học', 'Câu chuyện tình yêu đầy cảm động giữa hai nhân vật Ngạn và Hà Lan', 2009, '/images/books/images (1).jpg', '/books_content/MatBiec.epub');
INSERT INTO public.books VALUES (9, 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'Nguyễn Nhật Ánh', 'Văn học', 'Lối sống hồn nhiên, trong sáng của tuổi thơ qua góc nhìn nhân vật', 2015, '/images/books/images.jpg', '/books_content/nhasachmienphi-toi-thay-hoa-vang-tren-co-xanh.epub');
INSERT INTO public.books VALUES (140, 'Be Useful: Seven Tools for Life', 'Arnold Schwarzenegger', 'Kỹ năng & Phát triển bản thân', 'Vài tháng sau khi tôi rời văn phòng thống đốc vào năm 2011, thế giới xung quanh tôi sụp đổ.

Mọi chuyện không diễn ra tốt đẹp như vậy trong những năm trước đó. Sau khi giành chiến thắng trong cuộc tái tranh cử vang dội với 57 phần trăm phiếu bầu vào năm 2006, sau đó thông qua các chính sách môi trường đã truyền cảm hứng cho thế giới và thực hiện khoản đầu tư cơ sở hạ tầng lớn nhất trong lịch sử California—một khoản đầu tư sẽ phục vụ các tài xế, sinh viên và nông dân của

California rất lâu sau khi tôi ra đi—

hai năm rưỡi cuối cùng của tôi ở Điện Capitol, nơi tôi trải qua cuộc khủng hoảng tài chính toàn cầu, cảm giác như bị mắc kẹt trong một chiếc máy sấy quần áo với một đống gạch. Nó chẳng là gì ngoài việc đập liên hồi từ mọi hướng.

Năm 2008, khi cuộc khủng hoảng xảy ra, dường như một ngày nào đó mọi người bắt đầu mất nhà cửa, và ngày hôm sau chúng ta rơi vào cuộc suy thoái lớn nhất kể từ cuộc Đại suy thoái, tất cả chỉ vì một loạt các chủ ngân hàng tham lam đã khiến hệ thống tài chính thế giới suy thoái. đầu gối của nó. Một ngày nọ, California đang ăn mừng một khoản ngân sách kỷ lục cho phép tôi lập quỹ dự phòng. Ngày hôm sau, thực tế là ngân sách của California quá ràng buộc với Phố Wall đã khiến chúng tôi thiếu hụt 20 tỷ đô la và kéo chúng tôi gần như rơi vào tình trạng vỡ nợ. Tôi đã dành rất nhiều đêm khuya nhốt trong phòng với các lãnh đạo của cả hai đảng trong cơ quan lập pháp, cố gắng kéo chúng tôi ra khỏi bờ vực, đến mức có cảm giác như nhà nước có thể công nhận hợp pháp chúng tôi là đối tác trong nước.', 2008, '/images/books/ebook-Be-Useful-Seven-Tools-for-Life-by-Arnold-Schwarzenegger-tieng-viet.jpg', '/books_content/Be Useful Seven Tools for Life - Arnold Schwarzenegger.epub');
INSERT INTO public.books VALUES (4, 'Harry Potter và Hòn Đá Phù Thủy', 'J.K. Rowling', 'Khoa học viễn tưởng & fantasy', 'Cuộc phiêu lưu kỳ bí của Harry Potter', 1997, '/images/books/harry_potter1.jpg', '/books_content/HRPT.epub');
INSERT INTO public.books VALUES (3, '7 Thói Quen Thành Đạt', 'Stephen R. Covey', 'Kỹ năng & Phát triển bản thân', 'Phương pháp giúp bạn thành công', 1989, '/images/books/7thoiquenhieuqua.jpg', '/books_content/7thoiquen.epub');
INSERT INTO public.books VALUES (40, 'Định luật Murphy', 'Trương Văn Thành', 'Học thuật & Giáo trình', 'Murphy is a hero', 1999, '/images/books/dinh-luat-murphy.jpg', '/books_content/DinhLuatMufis.epub');
INSERT INTO public.books VALUES (42, 'Nhà Giả Kim', 'Paulo Coelho', 'Kỹ năng & Phát triển bản thân', '“Nhà Giả Kim” là một cuốn tiểu thuyết thuộc thể loại phi hư cấu, được viết bởi tác giả Paulo Coelho, xuất bản lần đầu tiên vào năm 1988 bằng tiếng Bồ Đào Nha. Cuốn sách nhanh chóng trở thành best-seller trên toàn thế giới và được dịch sang hơn 80 ngôn ngữ, bán được hơn 65 triệu bản, trở thành một trong những tác phẩm văn học được yêu thích nhất mọi thời đại', 1988, '/images/books/Nhagiakim.jpg', '/books_content/Nha Gia Kim - Paulo Coelho.epub');
INSERT INTO public.books VALUES (43, 'Bố Già', 'Mario Puzo', 'Văn học', 'Tiểu thuyết “Bố Già” với nhân vật Don Vito Corleone của tác giả Mario Puzo không chỉ được phủ bởi một tình khúc lãng mạn độc đáo, mà còn chứa đựng những sự kiện gay cấn xoay quanh ông ta. Sự kết hợp của hai yếu tố này đã tạo nên sức hấp dẫn đặc biệt cho cuốn sách. Tuy nhiên, Puzo không chỉ dừng lại ở việc làm cho “Bố Già” trở nên lãng mạn. Ông xây dựng câu chuyện dựa trên sự thật và tiếp cận nhân vật bằng cách miêu tả chân thực. Theo nhiều nguồn tư liệu gần đây, Don Vito Corleone ngoài đời thực là Don Vito Cascio Ferro, một trong những thủ lĩnh đầu tiên của Mafia Italia di cư sang Mỹ.', 1973, '/images/books/bogia.jpg', '/books_content/BoGia.epub');
INSERT INTO public.books VALUES (50, 'Yêu Xứ Sở, Thương Đồng Bào', 'Đoàn Công Lê Huy', 'Truyện tranh - Thiếu nhi', 'Yêu Xứ Sở, Thương Đồng Bào của tác giả Đoàn Công Lê Huy là một tác phẩm mang tính nhân văn sâu sắc, thể hiện tình yêu quê hương, đất nước và lòng thương yêu đồng bào. Cuốn sách xoay quanh những suy tư và cảm nhận của tác giả về quê hương và con người Việt Nam. Tác phẩm khắc họa những hình ảnh đẹp đẽ về xứ sở, từ cảnh vật thiên nhiên đến con người lao động, đồng thời phản ánh những khó khăn, thách thức mà người dân phải đối mặt trong cuộc sống hàng ngày.', 2024, '/images/books/1.jpg', '/books_content/YÃªu Xá»© Sá», ThÆ°Æ¡ng Äá»ng BÃ o - ÄoÃ n CÃ´ng LÃª Huy.epub');
INSERT INTO public.books VALUES (49, '8 Tố Chất Trí Tuệ Quyết Định Cuộc Đời Người Đàn Ông', 'Phan Quốc Bảo', 'Kỹ năng & Phát triển bản thân', '“8 Tố Chất Trí Tuệ Quyết Định Cuộc Đời Người Đàn Ông” của tác giả Phan Quốc Bảo là một cuốn sách tập trung vào việc phân tích và tìm hiểu về 8 yếu tố cốt lõi quyết định sự thành công và hạnh phúc của người đàn ông trong cuộc sống.

Tác phẩm này không chỉ đơn thuần là một hướng dẫn về cách thành công hay cách thức để đạt được mục tiêu, mà còn đào sâu vào tâm trí và tâm hồn của người đàn ông. Phan Quốc Bảo khám phá 8 yếu tố quan trọng mà anh cho rằng có thể làm nên sự khác biệt trong cuộc sống của mỗi người đàn ông, từ sự tự tin và lòng kiên nhẫn đến khả năng lãnh đạo và tư duy tích cực.', 1998, '/images/books/img774_6.jpg', '/books_content/8ToChat.epub');
INSERT INTO public.books VALUES (141, 'Hiểu Về Trái Tim', 'Minh Niệm', 'Kỹ năng & Phát triển bản thân', '“Hiểu Về Trái Tim” là một tác phẩm đặc biệt với tinh thần thiền sư Minh Niệm, một người thầy có những trải nghiệm độc đáo trong thiền định, trở thành niềm động viên tinh thần cho hàng triệu tâm hồn yêu thiền trên toàn cầu. Phong cách viết gần gũi với đời sống Việt Nam đã mang đến cho cuốn sách một hơi thở hoàn toàn mới mẻ.

Từng trang sách tỏa sáng những khái niệm đơn giản, nhưng chứa đựng sâu thẳm những triết lý tinh tế, chỉ cần ngẫm nghĩ một chút là ta có thể cảm nhận được dòng chảy tinh túy đang chảy trong từng câu từ.

Trong cuốn sách này, thiền sư Minh Niệm chia sẻ rằng, có nhiều người sống suốt đời mà không hiểu rõ trái tim của chính họ, không biết mình thực sự muốn điều gì, và không thể phân biệt được đúng và sai, lý và vô lý trong cuộc sống. Họ lãng phí cuộc đời và bỏ lỡ cơ hội để tận hưởng hạnh phúc và bình an từ bên trong. Cuốn sách như một đóa hoa sen mở rộng hướng về bản thân, giúp ta chạm tới những giá trị nhân văn như lòng bao dung, vị tha, lắng nghe và chia sẻ. Nó cũng khơi gợi khả năng chuyển hóa những cảm xúc tiêu cực như giận dữ, ghen tỵ, và tham lam thành năng lượng tích cực và bình yên.

Cuộc sống thường giấu những bài học quý giá dưới lớp vỏ bề ngoài, và ta chỉ thức tỉnh sau khi đã mất đi những điều quan trọng. Trong khi đó, cũng có những điều ta không hề hay biết rằng đã bỏ lỡ cho đến khi chúng xuất hiện trước mắt. “Hiểu Về Trái Tim” khơi gợi trong tâm hồn chúng ta những ước mơ đẹp, dẫn ta đến những nơi chúng ta mong muốn và trở nên người chúng ta muốn làm. Bởi cuộc đời chỉ trao cho chúng ta một cơ hội duy nhất để sống thật với niềm đam mê và ý nghĩa.

Hãy dành thời gian để thưởng thức cuốn sách “Hiểu Về Trái Tim” – món quà tinh thần sâu sắc mà Tiệm Sách xin trân trọng giới thiệu đến bạn!', 2006, '/images/books/Ebook-Hieu-ve-trai-tim.jpg', '/books_content/Hieu Ve Trai Tim - Minh Niem.epub');
INSERT INTO public.books VALUES (47, 'Trạng Quỳnh', 'Dân Gian', 'Truyện tranh - Thiếu nhi', 'Trạng Quỳnh – Trạng Quỷnh là một bộ truyện tranh thiếu nhi nhiều tập của Việt Nam được thực hiện bởi tác giả Kim Khánh, tập truyện đầu tiên mang tên "Sao sáng xứ Thanh" được Nhà xuất bản Đồng Nai phát hành giữa tháng 6 năm 2003.', 2003, '/images/books/TrangQuynh.jpg', '/books_content/TrangQuynhDanGian.epub');
INSERT INTO public.books VALUES (44, 'Đắc Nhân Tâm', 'Dale Carnegie', 'Tâm lý - Triết học', 'Đắc nhân tâm – How to win friends and Influence People  của Dale Carnegie là quyển sách nổi tiếng nhất, bán chạy nhất và có tầm ảnh hưởng nhất của mọi thời đại. Tác phẩm đã được chuyển ngữ sang hầu hết các thứ tiếng trên thế giới và có mặt ở hàng trăm quốc gia. 

Đây là quyển sách duy nhất về thể loại self-help liên tục đứng đầu danh mục sách bán chạy nhất (best-selling Books) do báo The New York Times bình chọn suốt 10 năm liền. Riêng bản tiếng Anh của sách đã bán được hơn 15 triệu bản trên thế giới.', 1970, '/images/books/dacnhantam.jpg', '/books_content/Dac Nhan Tam - Dale Carnegie.epub');
INSERT INTO public.books VALUES (48, 'Thao Túng Tâm Lý', 'Shannon Thomas', 'Tâm lý - Triết học', 'Cuốn sách “Thao Túng Tâm Lý” của tác giả Shannon Thomas là một nguồn thông tin quý giá về thao túng tâm lý và lạm dụng tiềm ẩn. Sách không chỉ giới thiệu về các khía cạnh của thao túng tâm lý và lạm dụng tâm lý, mà còn cung cấp cho người đọc một hành trình chữa lành bao gồm 6 giai đoạn.

Tác giả bắt đầu bằng việc giới thiệu đến độc giả những hiểu biết cơ bản về lạm dụng tâm lý nói chung và thao túng tâm lý nói riêng. Qua đó, người đọc sẽ hiểu rõ hơn về tính chất bí hiểm và âm thầm gây hại của thao túng tâm lý, cũng như cách mà nó có thể xảy ra trong bất kỳ môi trường nào và với bất kỳ đối tượng độc hại nào.', 1997, '/images/books/thao-tung-tam-ly.jpg', '/books_content/Thao Tung Tam Ly - Shannon Thomas.epub');
INSERT INTO public.books VALUES (144, 'Nghệ Thuật Tư Duy Chiến Lược', 'Barry J.Nalebuff', 'Kỹ năng & Phát triển bản thân', 'Nghệ Thuật Tư Duy Chiến Lược” – Chìa Khóa Để Hiểu Và Chiến Thắng Trò Chơi Cuộc Sống

Bạn có từng tin rằng thành công của những người xung quanh đều xuất phát từ “tài năng thiên bẩm”? Đó là một quan niệm sai lầm lớn. Thực tế, họ đã nắm vững nghệ thuật tư duy chiến lược – khả năng dự đoán động thái của người khác và biết cách phản ứng trong trò chơi cuộc sống. Bạn cũng có thể trở thành người chiến thắng trong trò chơi này với cuốn sách “Nghệ Thuật Tư Duy Chiến Lược” (The Art of Strategy)!

Tác giả Avinash K. Dixit và Barry J. Nalebuff, cả hai từng nổi danh với cuốn “Lý Thuyết Trò Chơi Trong Kinh Doanh – Co-operation”, đã đồng hành để mang đến cuốn sách về tư duy chiến lược này. Với sự hỗ trợ từ nhiều giáo sư hàng đầu, cuốn sách này đã trở thành một tài liệu quý giá về nghệ thuật tư duy chiến lược.

“Nghệ Thuật Tư Duy Chiến Lược” không chỉ là một cuốn sách, mà là hướng dẫn để bạn phát triển tư duy và chiến thắng trong mọi tình huống. Cuốn sách này không cung cấp bí quyết đơn giản cho một chiến lược thành công, mà hướng đến việc giúp bạn xây dựng tư duy linh hoạt và thích nghi với các trò chơi cuộc sống đa dạng.', 1998, '/images/books/Ebook-Nghe-thuat-tu-duy-chien-luoc.jpg', '/books_content/Nghe Thuat Tu Duy Chien Luoc - Barry J.Nalebuff.epub');
INSERT INTO public.books VALUES (145, 'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 'Nguyễn Nhật Ánh', 'Truyện tranh - Thiếu nhi', '“Cho Tôi Xin Một Vé Đi Tuổi Thơ” của Nguyễn Nhật Ánh là một hành trình đáng nhớ đưa bạn đọc trở về tuổi thơ hồn nhiên và đầy màu sắc. Cuốn sách này không chỉ đơn thuần là một tác phẩm văn học mà còn là một khoảnh khắc thần kỳ dành cho tâm hồn mỗi người.

Trong bối cảnh miền Trung Việt Nam nhỏ bé, năm 1985, chúng ta được làm quen với bốn nhân vật chính – cu Mùi, Hải cò, con Tủn, và Tí sún – với độ độc đáo riêng biệt. Cu Mùi, cậu bé thông minh và tò mò với niềm đam mê khoa học, luôn sẵn sàng khám phá thế giới xung quanh. Hải cò, người bạn đồng hành của Mùi, luôn tỏ ra hài hước và đem lại niềm vui cho mọi người. Con Tủn, cô bé xinh đẹp và thông minh, giữ nguyên sự dịu dàng và khả năng ghi nhớ xuất sắc. Tí sún, cậu bé mập mạp nhưng nhiều nghị lực, luôn đam mê khám phá thế giới xung quanh.

Cuốn sách mang đến cho độc giả những trò chơi và cuộc phiêu lưu không giới hạn, tạo ra những kí ức chân thực về tuổi thơ đáng nhớ. Các tình bạn chân thành, những pha nghịch ngợm, và những khoảnh khắc ngọt ngào tạo nên những giá trị nhân văn sâu sắc.

“Cho Tôi Xin Một Vé Đi Tuổi Thơ” không chỉ đơn thuần là một cuốn sách về tuổi thơ, mà còn là một hành trình giáo dục về cuộc sống. Tác phẩm này mang đến giá trị về tình bạn, lòng kiên nhẫn, và tầm quan trọng của việc hiểu rõ bản thân. Với một cốt truyện sôi nổi và những nhân vật đáng yêu, cuốn sách này là một tác phẩm văn học thú vị và đầy ý nghĩa.', 1996, '/images/books/3-3.jpg', '/books_content/Cho Toi Xin Mot Ve Di Tuoi Tho - Nguyen Nhat Anh.epub');
INSERT INTO public.books VALUES (147, 'Peter Pan', 'James M. Barrie', 'Truyện tranh - Thiếu nhi', 'Peter Pan của James M. Barrie không chỉ là một cuốn sách, nó là một cửa sổ mở ra thế giới đầy kỳ diệu của tuổi thơ, nơi bạn có thể bay xa và tận hưởng những cuộc phiêu lưu không giới hạn.

Cuốn tiểu thuyết tưởng chừng như dành cho thiếu nhi nhưng thực chất lại chứa đựng những bài học quý báu về tình bạn và giá trị cuộc sống. Chúng ta gặp gỡ Peter Pan, một cậu bé luôn ở tuổi thiếu niên và không bao giờ lớn lên, cùng với các bạn của cậu ở Neverland – một hòn đảo thần tiên đầy màu sắc và cuộc phiêu lưu.

James M. Barrie, một tác giả có kinh nghiệm, đã tạo ra một câu chuyện hấp dẫn và đầy tính phiêu lưu. Những trở ngại và nguy hiểm tại Neverland đan xen với những giây phút vui vẻ và hạnh phúc. Cuốn sách khiến bạn nhớ về những khoảnh khắc đáng quý trong tuổi thơ và suy ngẫm về những giá trị quan trọng trong cuộc sống.

Peter Pan không chỉ là một nhân vật vô cùng cuốn hút, mà Neverland cũng là một nơi đáng khám phá, nơi bạn sẽ gặp những sinh vật kỳ lạ và trải qua những cuộc phiêu lưu thú vị.', 1990, '/images/books/Ebook-Peter-Pan.jpg', '/books_content/Peter Pan - James M. Barrie.epub');
INSERT INTO public.books VALUES (149, 'Dế Mèn Phiêu Lưu Ký', 'Tô Hoài', 'Truyện tranh - Thiếu nhi', '“Dế Mèn Phiêu Lưu Ký” là một trong những tác phẩm nổi tiếng và được yêu thích của tác giả Tô Hoài – một nhà văn nổi tiếng của văn học Việt Nam. Tô Hoài (1920-2014) là một trong những nhà văn tài hoa của thế hệ ở miền Bắc Việt Nam, ông được biết đến với những tác phẩm hài hước, du dương và đậm chất dân gian.

“Dế Mèn Phiêu Lưu Ký” là câu chuyện vui nhộn và đầy hài hước về cuộc hành trình của chú Dế Mèn – một con dế thông minh và tinh nghịch. Cuộc phiêu lưu bắt đầu khi Dế Mèn quyết định rời khỏi tổ ấm của mình để tìm kiếm cuộc sống mới. Trên đường đi, chú đã gặp gỡ và kết bạn với nhiều loài động vật khác nhau, từ con cá sấu, con chuột, đến con cua, và nhiều loài động vật khác.

Trong hành trình của mình, Dế Mèn đã trải qua nhiều khó khăn và thử thách, nhưng cũng không thiếu những tràng cười và niềm vui. Tác phẩm mang lại những bài học sâu sắc về tình bạn, sự kiên nhẫn, và lòng dũng cảm.

“Dế Mèn Phiêu Lưu Ký” không chỉ hấp dẫn đối với các em nhỏ với câu chuyện vui nhộn, mà còn gợi mở cho người đọc lớn những suy tư về cuộc sống, giá trị con người và tình bạn. Tô Hoài đã tài hoa biến những nhân vật động vật vụng về thành những người bạn thân thiết đầy nhân cách.

Tác phẩm đã trở thành một trong những câu chuyện cổ tích đặc sắc và cổ điển của văn học thiếu nhi Việt Nam, gắn liền với tuổi thơ của hàng triệu độc giả và truyền đi những giá trị nhân văn, tình yêu thiên nhiên mà Tô Hoài muốn gửi gắm.', 2002, '/images/books/De-Men-Phieu-Luu-Ky.jpg', '/books_content/De Men Phieu Luu Ky - To Hoai.epub');
INSERT INTO public.books VALUES (150, 'Hoàng Tử Bé', 'Antoine De Saint-Exupéry', 'Truyện tranh - Thiếu nhi', '“Hoàng Tử Bé” (Le Petit Prince) của Antoine de Saint-Exupéry là một huyền thoại văn học đầy sức hút, là một tác phẩm mang tính biểu tượng không chỉ cho trẻ em mà còn cho mọi người trên toàn cầu. Cuốn sách này đã chào đời vào năm 1943 và từ đó trở thành một bức tranh tinh tế về sự trưởng thành và hiểu biết về cuộc sống.

Bằng cách kể câu chuyện của một phi công bị mất đường giữa cõi sa mạc Sahara, tác giả giới thiệu chúng ta với Hoàng Tử Bé – một nhân vật huyền bí đến từ hành tinh khác. Cuộc gặp gỡ này trở thành một cuộc hành trình tinh thần qua những hành tinh khác nhau của tâm hồn chúng ta.

Mỗi hành tinh mà Hoàng Tử Bé đến đều chứa trong mình những nhân vật và tình huống độc đáo, từ người điên đảo đến chú bò bằng đá. Nhưng điều quan trọng hơn, trên mỗi hành tinh đó, chúng ta học được những bài học quý báu về cuộc sống và nhận ra rằng đôi khi, để hiểu sâu hơn về thế giới xung quanh, ta cần phải nhìn từ một góc nhìn khác.

“Hoàng Tử Bé” không chỉ là một cuốn sách mà là một tác phẩm nghệ thuật với cốt truyện lôi cuốn và sâu sắc. Bằng ngôn ngữ đơn giản nhưng lôi cuốn, Antoine de Saint-Exupéry giúp chúng ta dễ dàng tiếp cận những khía cạnh phức tạp của cuộc sống.

Cuốn sách này là một bức tranh kỳ diệu về lòng nhân ái, tình yêu, và sự trong sáng trong thế giới đầy phức tạp của chúng ta. “Hoàng Tử Bé” đã trở thành một tác phẩm vĩ đại vượt qua thời gian, mở ra cửa vào thế giới của sự trưởng thành và sáng tạo, và nó sẽ luôn luôn đánh thức lòng trẻ con trong trái tim mọi người.', 1993, '/images/books/1-1.jpg', '/books_content/Hoang Tu Be - Antoine De Saint-Exupery.epub');
INSERT INTO public.books VALUES (151, 'Tâm Lý Học Dành Cho Lãnh Đạo', 'Dean Tjosvold', 'Tâm lý - Triết học', '“Tâm Lý Học Dành Cho Lãnh Đạo” không chỉ là một cuốn sách, mà là một hành trình sâu sắc vào lý thuyết và thực tế của việc lãnh đạo. Dean Tjosvold không chỉ là tác giả, mà còn là người hướng dẫn chân thành, chia sẻ những hiểu biết sâu sắc từ nghiên cứu và trải nghiệm của mình.

Ngay từ chương 1, cuốn sách mở đầu với một định nghĩa táo bạo về lãnh đạo – không chỉ là việc quản lý, mà là quá trình tạo ra sự thay đổi đích thực trong một nhóm. Những từ ngữ của tác giả không chỉ chạm đến trí óc mà còn nói đến trái tim, mời gọi chúng ta suy ngẫm về ý nghĩa sâu sắc của việc dẫn dắt người khác.

Chương 2 không chỉ đơn thuần là về việc xây dựng mối quan hệ với cấp dưới, mà là về việc tạo nên những liên kết có ý nghĩa. Tác giả không chỉ giáo dục mà còn truyền đạt tầm quan trọng của sự nhạy bén trong giao tiếp (Chương 3) và khả năng giải quyết xung đột (Chương 4) – những yếu tố cần thiết cho một lãnh đạo xuất sắc.

Cuốn sách không chỉ giới thiệu về cách tạo động lực cho nhân viên (Chương 5) mà còn nhấn mạnh về tầm quan trọng của việc đổi mới trong lãnh đạo (Chương 6). Tjosvold không ngần ngại chạm vào thách thức của việc lãnh đạo trong môi trường đa văn hóa và toàn cầu (Chương 7), cũng như sức mạnh của lãnh đạo trong thời đại công nghệ (Chương 8).

Với tầm nhìn vượt thời đại, Chương 9 đưa ra cái nhìn táo bạo về tương lai của lãnh đạo, nhấn mạnh rằng khả năng thích ứng với sự biến đổi nhanh chóng của thế giới là chìa khóa.

Cuốn sách không chỉ là một nguồn tri thức mà còn là hành trình tìm kiếm sự hiểu biết bản thân và xã hội. Đọc giả không chỉ học về kỹ thuật, mà còn được tận hưởng sự sâu sắc của tâm hồn người lãnh đạo. “Tâm Lý Học Dành Cho Lãnh Đạo” không chỉ dành cho những người đang nắm giữ vị trí quản lý, mà còn là bức tranh rực rỡ về bản chất của con người – người lãnh đạo trong chúng ta.', 2004, '/images/books/kw0g8be6.png', '/books_content/Tam Ly Hoc Danh Cho Lanh Dao - Dean Tjosvold.epub');
INSERT INTO public.books VALUES (152, 'Đàn Ông Sao Hỏa, Đàn Bà Sao Kim', 'John Gray', 'Tâm lý - Triết học', 'Đàn Ông Sao Hỏa, Đàn Bà Sao Kim của tác giả John Gray là một tác phẩm nổi tiếng về quan hệ nam nữ, xuất bản lần đầu vào năm 1992 và đã đạt doanh số bán hơn 15 triệu bản trên toàn cầu. John Gray, một tiến sĩ tâm lý và chuyên gia trị liệu gia đình, đã tạo nên một tác phẩm mang tính ẩn dụ mạnh mẽ để giải thích sự khác biệt giữa nam và nữ trong cách nghĩ, cảm xúc, và cách tiếp cận vấn đề.

Cuốn sách đưa ra ý tưởng rằng nam và nữ đến từ hai hành tinh khác nhau, tức là sao Hỏa và sao Kim, để mô tả sự đa dạng và phức tạp của tâm lý con người. Gray cung cấp nhiều lời khuyên và kỹ thuật để cải thiện giao tiếp, động viên, hiểu biết và tạo ra sự hài hòa trong mối quan hệ nam nữ.

Với 13 chương, mỗi chương đều đề cập đến một khía cạnh cụ thể của quan hệ nam nữ, như giải quyết mâu thuẫn, quản lý gia đình, bí mật và sự truyền đạt cảm xúc. Cuốn sách không chỉ giúp độc giả hiểu rõ hơn về bản chất của nam và nữ mà còn đề xuất những giải pháp thực tế để tạo ra một môi trường quan hệ tích cực.

Tuy nhiên, sách cũng nhận được những ý kiến phản biện, với những người cho rằng tác giả quá đơn giản hóa và đặt ra những quy tắc cứng nhắc cho nam và nữ, không tính đến sự đa dạng văn hóa, giáo dục và cá tính. Một số người thậm chí cho rằng cuốn sách đã bỏ qua những yếu tố quan trọng khác có thể ảnh hưởng đến quan hệ nam nữ.

Mặc dù vấp phải những ý kiến trái chiều, “Đàn Ông Sao Hỏa, Đàn Bà Sao Kim” vẫn được đánh giá cao bởi nhiều độc giả và chuyên gia. Cuốn sách không chỉ mang lại sự thú vị với những đọc giả quan tâm đến tâm lý con người mà còn là một nguồn kiến thức hữu ích để cải thiện mối quan hệ và hiểu biết giữa nam và nữ. Đọc giả nên tiếp cận cuốn sách với tinh thần phê phán và sự lựa chọn thông minh khi áp dụng những lời khuyên của tác giả vào thực tế cuộc sống.', 1997, '/images/books/dan-ong-sao-hoa-dan-ba-sao-kim.jpg', '/books_content/Dan Ong Sao Hoa, Dan Ba Sao Kim - John Gray.epub');
INSERT INTO public.books VALUES (154, 'Trở Về Từ Xứ Tuyết', 'Nguyên Phong', 'Tâm lý - Triết học', 'Trở Về Từ Xứ Tuyết là một cuốn sách tương tác với tâm hồn và khám phá sự kỳ diệu của văn hóa và tâm linh Tây Tạng. Tác giả, Nguyên Phong, đã mở ra cánh cửa của trái tim và tâm hồn của mình để dẫn dắt bạn qua một cuộc hành trình đầy thách thức và những phát hiện kỳ diệu.

Cuốn sách này không chỉ là một sự giới thiệu về văn hóa Tây Tạng và triết lý Phật giáo, mà còn là một hành trình tới những khoảnh khắc đáng quý trong cuộc sống và những trạng thái tâm hồn cao quý. Từ những chương về tâm linh và thiền định đến những câu chuyện về tình yêu và lòng thương xót, cuốn sách đánh thức và truyền cảm hứng cho tâm hồn của bạn.

Với ngôn ngữ đẹp và lời kể tương tác, Nguyên Phong tặng bạn những bài học về tâm linh mà bạn có thể áp dụng trong cuộc sống hàng ngày. Trở Về Từ Xứ Tuyết không chỉ là một cuốn sách, mà là một lời kêu gọi đưa bạn ra khỏi cuộc sống hàng ngày để thăm dò và khám phá thế giới bên ngoài và bên trong.

Cuốn sách này là một món quà tinh thần dành cho những người tìm kiếm sự hiểu biết sâu sắc và sự giác ngộ. Nó đưa bạn đến những nơi xa lạ và đưa bạn trở lại với chính mình, mang đến cho bạn cái nhìn mới về cuộc sống và vũ trụ.

Nếu bạn đang tìm kiếm sự kết nối tinh thần và muốn khám phá những khía cạnh mới của cuộc sống và tâm linh, thì Trở Về Từ Xứ Tuyết là một hướng dẫn thú vị và tinh thần để bạn bắt đầu cuộc hành trình của mình.', 1990, '/images/books/Ebook-Tro-ve-tu-xu-tuyet.jpg', '/books_content/Tro Ve Tu Xu Tuyet - Nguyen Phong.epub');
INSERT INTO public.books VALUES (155, 'Từng Qua Tuổi 20', 'Iain Hollingshead', 'Kỹ năng & Phát triển bản thân', 'Cuộc sống là một hành trình đầy màu sắc, và “Từng Qua Tuổi 20” của Iain Hollingshead là bức tranh sống động về những trải nghiệm và nhận thức của tác giả trong giai đoạn tuổi 20, một thời kỳ mà ông tự gọi là “tuổi khủng hoảng”. Câu chuyện bắt đầu với sự tốt nghiệp đại học của Iain và sự xuất hiện của những cơ hội và thách thức đầu tiên của cuộc đời trưởng thành.

Iain Hollingshead, mặc dù có một công việc ổn định và mối quan hệ mặn nồng, nhưng lại cảm thấy hỗn loạn và không hài lòng. Tưởng chừng như có tất cả mọi thứ, ông nhận ra rằng còn thiếu một cái gì đó, một ý nghĩa đặc biệt trong cuộc sống của mình. Để tìm kiếm câu trả lời, ông quyết định bắt đầu hành trình khám phá chính bản thân mình.

Việc đi du lịch trên khắp thế giới trở thành cuộc phiêu lưu của Iain, nơi ông gặp gỡ những con người đa dạng và học hỏi từ mỗi cuộc gặp gỡ. Những chương về châu Âu và châu Á đều là những hành trình mới mẻ và tràn đầy ý nghĩa.

Cuối cùng, Iain Hollingshead không chỉ tìm thấy câu trả lời cho những câu hỏi của mình mà còn học được rằng cuộc sống là một hành trình không ngừng. Mỗi người phải tự tìm ra con đường của mình, và mỗi giai đoạn trong cuộc sống đều quan trọng và đáng trân trọng.

“Từng Qua Tuổi 20” không chỉ là một cuốn sách, mà là một bức tranh sống về sự phát triển và tự khám phá. Câu chuyện này không chỉ đưa độc giả đến những địa điểm mới mẻ, mà còn mở ra những cánh cửa tinh tế về những giá trị cơ bản trong cuộc sống.

Với ngôn ngữ sôi động và tâm huyết, Iain Hollingshead đã tạo nên một tác phẩm đầy cảm xúc và ý nghĩa. “Từng Qua Tuổi 20” là một cuốn sách đầy cuốn hút, làm cho người đọc không chỉ thưởng thức câu chuyện mà còn nhận thức sâu sắc về chính bản thân mình.', 1999, '/images/books/24m69nes.png', '/books_content/Tung Qua Tuoi 20 - Iain Hollingshead.epub');
INSERT INTO public.books VALUES (156, 'Những Bước Đơn Giản Đến Ước Mơ', 'Steven K. Scott', 'Kỹ năng & Phát triển bản thân', '“Những Bước Đơn Giản Đến Ước Mơ” của Steven K. Scott không chỉ là một cuốn sách thông thường, mà là một hành trình đầy kỳ diệu đưa bạn từ thế giới của ước mơ đến thế giới của hiện thực. Tác phẩm này được chia thành 8 phần, mỗi phần chạm vào một góc khuất quan trọng của việc biến ước mơ thành sự thật.

Trong phần 1, bạn sẽ khám phá khả năng xác định mục tiêu một cách rõ ràng và cụ thể. Đây không chỉ là việc đặt ra mục tiêu, mà là việc khắc họa chúng trong đầu bạn với sự tương quan và thời hạn chặt chẽ.

Phần 2 là bước tiếp theo, giúp bạn xây dựng một bản đồ chiến lược vững chắc. Từ việc phân bổ thời gian đến việc đánh bại những trở ngại, bạn sẽ tìm thấy một con đường chi tiết đưa bạn đến ước mơ của mình.

Không chỉ dừng lại ở đó, phần 3 sẽ hướng dẫn bạn thực hiện kế hoạch hành động. Đây là nơi bạn biến ước mơ hàng tuần và hàng ngày thành hiện thực, và bạn sẽ học cách điều chỉnh nó để duy trì sự phát triển.

Cuốn sách còn khám phá việc duy trì động lực (phần 4), đối mặt với thất bại (phần 5), và kiên nhẫn (phần 6). Nó giúp bạn tìm hiểu cách tận hưởng thành công (phần 7) khi bạn đạt được mục tiêu.

“Những Bước Đơn Giản Đến Ước Mơ” không chỉ đơn thuần là một cuốn sách, mà là một hướng dẫn thực tế, dựa trên những câu chuyện và ví dụ sống động, giúp bạn tiến bước từ ước mơ đến hiện thực. Nếu bạn đang tìm kiếm một cách để biến ước mơ của mình thành hiện thực, thì đây chính là cuốn sách bạn không thể bỏ qua.', 2023, '/images/books/Nhung-buoc-don-gian-den-giac-mo.jpg', '/books_content/Nhung Buoc Don Gian Den Uoc Mo - Steven K. Scott.epub');
INSERT INTO public.books VALUES (157, ' Luyện trí nhớ', 'Alpha Book biên soạn', 'Kỹ năng & Phát triển bản thân', 'Luyện Trí Nhớ – Cuốn Sách Thăng Hoa Tư Duy

Trong thế giới hối hả, khao khát sự phát triển bản thân không bao giờ dừng lại, cuốn sách “Luyện Trí Nhớ” do bàn tay tài hoa của Alpha Books chắp cánh, là một hướng dẫn thiết thực đưa bạn vào hành trình chinh phục khả năng trí nhớ vượt ra ngoài giới hạn.

Hòa mình vào từng trang sách, bạn sẽ bắt đầu cuộc hành trình tìm hiểu sâu hơn về bản chất của trí nhớ, khám phá cấu trúc phức tạp mà tạo nên chúng, và đồng thời, tìm hiểu về cách mà trí nhớ hoạt động – một quá trình kỳ diệu đan xen giữa hình ảnh, thông tin và cảm xúc. Cuốn sách không chỉ đơn thuần giới thiệu khái niệm, mà hóa thân thành một hướng dẫn thực hành mê hoặc.

Phần đầu tiên của cuốn sách, như một lời đầu mở đầy sự kì vọng, dành riêng cho việc giúp bạn thấu hiểu về bản thân mình hơn. Nó không chỉ chẳng làm bạn cảm thấy mình đang bị đánh lừa bởi những hình ảnh hoặc tưởng tượng mà bạn tưởng như đã ghi nhớ, mà còn khiến bạn thấu hiểu về những yếu tố ẩn sau sự kém hiệu quả của trí nhớ, từ cảm xúc đến thói quen.

Sau khi đã khám phá mê cung tinh thần của trí nhớ, phần thứ hai của cuốn sách chính là hướng dẫn thực hành, những bài tập đầy mê hoặc để rèn luyện khả năng ghi nhớ của bạn. Không có khung cảnh nào mà bạn không thể ghi nhớ; từ con số đến ngôn ngữ, từ sự kiện lịch sử đến những kiến thức học thuật, từ gương mặt đến địa điểm xa lạ. Từng bài tập được thiết kế không chỉ dựa trên tâm hồn sáng tạo, mà còn dựa trên cơ sở khoa học, giúp bạn thực sự nắm vững cách tập trí nhớ hiệu quả và bền vững.

Cuốn sách không phân biệt đối tượng, không phân loại tuổi tác hay vị trí xã hội. Từ những học sinh đang bước chân vào thế giới tri thức, đến những người đi làm đầy thách thức, hay thậm chí là những người cao tuổi muốn giữ vững tinh thần sắc sảo của tâm trí, “Luyện Trí Nhớ” trở thành hợp âm tinh thần đưa mọi người vào đỉnh cao của khả năng kì diệu này.

Đừng bao giờ giới hạn sự tiến bộ của chính mình. “Luyện Trí Nhớ” không chỉ là cuốn sách, mà là một cơ hội mở cửa tương lai của bạn, giúp bạn khám phá và cải thiện khả năng trí nhớ vốn dĩ đã có. Đừng chỉ là người đọc, hãy là người hưởng thụ và tận hưởng những khoảnh khắc kì diệu mà trí nhớ mang lại.', 2012, '/images/books/Ebook-Luyen-tri-nho-1.jpg', '/books_content/Luyen tri nho - Alpha Book bien soan.epub');
INSERT INTO public.books VALUES (158, 'Muôn Kiếp Nhân Sinh', 'Nguyên Phong', 'Kỹ năng & Phát triển bản thân', '“Muôn Kiếp Nhân Sinh” là một tác phẩm văn học nổi tiếng của tác giả Nguyên Phong. Được viết thành 3 phần, phần 1 là lời khởi đầu cho một cuộc hành trình tâm linh đầy phiêu lưu và sâu sắc.

Với ngòi bút tinh tế, Nguyên Phong đã xây dựng một câu chuyện đan xen giữa quá khứ và hiện tại, hư cấu và hiện thực. Cuốn sách khám phá sâu vào thế giới tâm hồn, hỏi về ý nghĩa và định hướng cuộc sống. Từ những tình tiết đẹp đẽ và sâu sắc, đến những mảnh ghép truyền cảm hứng, “Muôn Kiếp Nhân Sinh” phần 1 gợi mở những triết lý tâm linh sâu thẳm và thú vị.

Tác phẩm mang lại những suy tư về cuộc sống, cái đẹp và cách tìm kiếm ý nghĩa trong từng khoảnh khắc. Được viết bằng ngôn ngữ tinh tế, sáng tạo và màu sắc, “Muôn Kiếp Nhân Sinh” phần 1 hứa hẹn là một trải nghiệm đọc thú vị và cảm động.

Đối với những ai quan tâm đến triết lý tâm linh, tìm kiếm ý nghĩa cuộc sống và muốn khám phá những điều mới mẻ trong tác phẩm văn học, “Muôn Kiếp Nhân Sinh” phần 1 là một cuốn sách đáng để đọc và suy ngẫm. Từ những trang sách này, độc giả sẽ khám phá ra những khía cạnh mới về tình yêu, đạo đức, và ý nghĩa của cuộc sống.', 2023, '/images/books/Bia-Sach-Muon-Kiep-Nhan-Sinh-1.jpeg', '/books_content/Muon Kiep Nhan Sinh - Nguyen Phong.epub');
INSERT INTO public.books VALUES (159, 'Tại Sao Chúng Ta Không Hạnh Phúc?', 'Phi Tuyết', 'Kỹ năng & Phát triển bản thân', 'Tại Sao Chúng Ta Không Hạnh Phúc? là một tác phẩm đầy sâu sắc của tác giả Phi Tuyết, một nhà văn tài năng của Việt Nam. Cuốn sách này là một cuộc hành trình tri thức sâu xa vào tâm hồn con người, đi tìm câu trả lời cho một trong những câu hỏi cổ điển nhất của cuộc sống: “Tại sao chúng ta không hạnh phúc?”

Với lối viết tinh tế và tri thức sâu rộng, Phi Tuyết đưa ra những suy tư sâu xa về ý nghĩa của hạnh phúc và tại sao nó thường trở nên khó khăn để đạt được. Cuốn sách không chỉ tập trung vào khía cạnh tâm lý, mà còn đi sâu vào những yếu tố xã hội, văn hóa, và tâm hồn mà ảnh hưởng đến hạnh phúc của con người.

Phi Tuyết không chỉ đưa ra những câu trả lời, mà còn đặt ra những câu hỏi thú vị về cách chúng ta hiểu về hạnh phúc và tạo nên nó trong cuộc sống hàng ngày. Cuốn sách này là một cuộc thám hiểm tâm hồn và tư duy, mời bạn đọc cùng nhau suy ngẫm về mục tiêu cuộc sống và cách chúng ta có thể tìm kiếm hạnh phúc trong thế giới phức tạp hiện nay.

Nếu bạn đang tìm kiếm một cuốn sách sẽ khiến bạn suy tư, thúc đẩy tinh thần nghiên cứu và giúp bạn đạt được cái nhìn sâu sắc hơn về ý nghĩa của cuộc sống và hạnh phúc, thì Tại Sao Chúng Ta Không Hạnh Phúc? của tác giả Phi Tuyết là một lựa chọn tuyệt vời. Cuốn sách này sẽ là một hướng dẫn thông minh và sâu lắng, giúp bạn khám phá những khía cạnh mới mẻ về cuộc sống và hạnh phúc.', 1916, '/images/books/Ebook-Tai-sao-chung-ta-khong-hanh-phuc-1.jpg', '/books_content/Tai Sao Chung Ta Khong Hanh Phuc - Phi Tuyet.epub');
INSERT INTO public.books VALUES (160, 'Tôi Tài Giỏi, Bạn Cũng Thế', 'Adam Khoo', 'Kỹ năng & Phát triển bản thân', 'Cuốn sách “Tôi Tài Giỏi, Bạn Cũng Thế” của Adam Khoo không chỉ là một cuốn sách học tập thông thường, mà là một hành trình khám phá về bản thân và sức mạnh tiềm ẩn bên trong mỗi người. Từ những trang sách, người đọc không chỉ học được cách học tập hiệu quả mà còn nhận ra sức mạnh của tư duy và ý chí.

Mỗi chương của cuốn sách là một hành trình sâu sắc đưa người đọc đi qua những bước cần thiết để thay đổi tư duy và tạo ra sự đột phá trong học tập và cuộc sống. Từ việc nhìn nhận và thay đổi tư duy, đặt ra mục tiêu, lập kế hoạch đến việc quản lý thời gian và học tập hiệu quả, mỗi câu chuyện, mỗi ví dụ thực tế được tác giả trình bày đều là những hướng dẫn thực tế, áp dụng ngay trong cuộc sống hàng ngày.

Tác giả không chỉ dừng lại ở việc trình bày về cách học tập mà còn là hướng dẫn về việc thay đổi tư duy. Cuốn sách giúp người đọc nhận ra rằng, để thay đổi cuộc sống và đạt được mục tiêu, không chỉ cần kiến thức mà còn cần tư duy tích cực và quyết tâm.

Những điểm nhấn quan trọng trong cuốn sách này:

Sức mạnh của tư duy: Tư duy là nền tảng quan trọng, và việc thay đổi tư duy sẽ mở ra cánh cửa cho sự đổi mới và thành công.

Xác định mục tiêu: Đặt ra mục tiêu rõ ràng và cụ thể, chúng ta sẽ có động lực mạnh mẽ hơn để theo đuổi.

Quản lý thời gian và học tập hiệu quả: Việc quản lý thời gian và học tập hiệu quả không chỉ giúp chúng ta tiết kiệm thời gian mà còn tạo ra kết quả đáng giá.

Cuốn sách không chỉ dành cho những người muốn rèn luyện kiến thức mà còn là nguồn động viên cho những ai muốn thay đổi cuộc sống của mình. Đó là cuốn sách không chỉ giúp bạn trở thành người học giỏi, mà còn trở thành phiên bản tốt nhất của chính mình.', 1922, '/images/books/ev4bdbcg.png', '/books_content/Toi Tai Gioi, Ban Cung The - Adam Khoo.epub');
INSERT INTO public.books VALUES (161, 'Cát Bụi Chân Ai', 'Tô Hoài', 'Văn học', '“Đường Vào Ký Ức – Cát Bụi Chân Ai Của Tô Hoài”

Trang sách mở ra những ký ức dưới bàn tay tài hoa của nhà văn Tô Hoài, mang tên “Cát Bụi Chân Ai”. Đó là hành trình xuyên thấu thời gian, đưa chúng ta vào những thước phim kỷ niệm của ông sau những năm tháng lưu lạc miền Bắc.

Tựa sách không chỉ là chốn trải nghiệm mà còn chứa đựng sự tôn vinh cho những người thân yêu và những người bạn đã lặng lẽ kề cận bên ông. Đây không chỉ là cuộc hành trình qua thời gian, mà là hành trình qua tâm hồn, khám phá về chính bản thân và về tất cả những người mà cuộc đời ông đã kết nối.

Những trang sách vẻ vang những câu chuyện thấm đẫm tình cảm, đậm chất nhân văn. Đó là những thước phim cuộc sống, những tâm hồn, và những ước mơ. Như một bức tranh đầy màu sắc, cuốn sách mở ra cả một thế giới, khắc họa cuộc sống thường ngày và hành trình vượt qua khó khăn của những người bình thường.

Những câu nói trong sách như những hạt cát nhỏ, dẫn chúng ta theo bước chân của những người đã từng đi qua. “Đời như dòng sông, cuộn trào và êm đềm. Cát bụi vô tri vô giác, nhưng con người lại có khả năng biến nó thành tác phẩm nghệ thuật đẹp đẽ.” Nhưng quan trọng hơn, đó là những dòng chữ về tình bạn, về tình yêu, và về giá trị những người đi cùng ta.

“Đường Vào Ký Ức – Cát Bụi Chân Ai” không chỉ là cuốn sách, mà là cánh cửa mở ra một thế giới đẹp đẽ và ý nghĩa. Đó là một bài học về tình thân, về con người, và về vẻ đẹp của cuộc sống. Hãy cùng chúng tôi bước vào cuốn sách này, để tìm thấy chính mình và để những trang sách kỳ diệu làm cho cuộc sống thêm phong phú và ý nghĩa.', 1990, '/images/books/Ebook-Cat-bui-chan-ai.jpg', '/books_content/Cat Bui Chan Ai - To Hoai.epub');
INSERT INTO public.books VALUES (162, 'Lịch Sử Vạn Vật', 'NXB Tổng hợp thành phố HCM', 'Khoa học - Công nghệ', '“Lịch sử Vạn Vật” – Khám Phá Hành Trình Cuốn Sách Đỉnh Cao Khoa Học

Một cuốn sách không chỉ đơn thuần là một quyển văn thư khoa học, mà là một hành trình phiêu lưu đầy thú vị trong thế giới kỳ diệu của vũ trụ và cuộc sống. Tác giả tài năng người Anh, Bill Bryson, đã tạo nên một kiệt tác từng được xuất bản vào năm 2003, và từ đó đã lan tỏa khắp toàn cầu bằng hơn 40 ngôn ngữ, đồng thời trở thành một trong những cuốn sách bán chạy nhất mọi thời đại.

Cuốn “Lịch sử Vạn Vật” không chỉ là một sự đối mặt với những số liệu khoa học khô khan và khó hiểu. Thay vào đó, Bill Bryson biến những thảo luận phức tạp thành câu chuyện đầy sức sống về vũ trụ. Bạn sẽ bắt đầu hành trình này từ khoảnh khắc đầu tiên của sự sáng tạo – Big Bang – và từ đó, bạn sẽ tiến vào thế giới của vũ trụ với những tinh túy về thiên hà, ngôi sao, hành tinh, và những tiểu hành tinh huyền bí. Sự giãn nở của vũ trụ và câu chuyện cuối cùng của nó cũng được trình bày một cách hấp dẫn.

Tiếp theo, cuốn sách đưa bạn vào lĩnh vực của Trái Đất, với lịch sử hình thành và phát triển của hành tinh xinh đẹp này. Từ những ngày đầu tiên, qua những quy luật địa chất, khí hậu đang thay đổi và cuộc sống tự nhiên đang phát triển, Bill Bryson không chỉ giảng giải mà còn biến thành một câu chuyện đầy mê hoặc.

Cuối cùng, “Lịch sử Vạn Vật” dẫn bạn vào cuộc hành trình tiến hóa của sự sống. Từ những vi khuẩn đơn bào đầu tiên cho đến sự trỗi dậy của động vật và thực vật, cuốn sách này không chỉ giúp bạn hiểu rõ hơn về sự phát triển của cuộc sống mà còn đặt ra câu hỏi về tương lai của nó.

Bill Bryson đã viết cuốn sách này với một lối văn phong hài hước, dí dỏm và dễ hiểu. Anh ấy không bao giờ để cho kiến thức khoa học trở nên khó nhằn hay tẻ nhạt. Thay vào đó, anh ấy sử dụng hình ảnh minh họa, ví dụ thú vị và các câu chuyện ngắn để giải thích những khái niệm phức tạp một cách rõ ràng.

Những điều nổi bật trong cuốn sách này không thể đếm hết, nhưng chắc chắn rằng bạn sẽ được tham gia vào một cuộc hành trình tận hưởng kiến thức sâu sắc về thế giới xung quanh mà không cần phải bỏ qua những khái niệm khoa học phức tạp. Cuốn sách đã nhận được nhiều lời khen ngợi từ giới phê bình và bạn đọc, và chắc chắn sẽ là một trang sách đáng đọc cho những ai muốn tìm hiểu sâu hơn về vũ trụ và cuộc sống.', 2004, '/images/books/lich-su-van-vat_1.jpg', '/books_content/Lich Su Van Vat - Bill Bryson.epub');
INSERT INTO public.books VALUES (163, 'Não Bộ Kể Gì Về Bạn?', 'David Eagleman', 'Khoa học - Công nghệ', 'Trong thế giới phức tạp của não bộ, sự kỳ diệu của tâm trí con người tiết lộ những bí ẩn đầy mê hoặc. Cuốn sách “Não Bộ Kể Gì Về Bạn?” của tác giả David Eagleman sẽ đưa bạn vào cuộc phiêu lưu thú vị, để bạn khám phá khối chất đa dạng nhưng rất ít được hiểu biết này và tìm hiểu về chính bản thân mình.

David Eagleman, một nhà khoa học thần kinh đẳng cấp tại Đại học Stanford, đã chuyển tải kiến thức khoa học phức tạp một cách dễ hiểu và sinh động. Cuốn sách này không chỉ đề cập đến những nghiên cứu mới nhất về “khoa học não” mà còn đưa bạn vào một hành trình sâu rộng qua lịch sử phát triển và tương lai tiềm năng của tâm trí con người.

Từ việc hình thành ký ức đến quyết định và sự sáng tạo, từ những hiểu biết về vùng não quan trọng đến những thách thức khoa học đầy táo bạo, cuốn sách này mang đến cho bạn cái nhìn đa chiều về khả năng vượt qua giới hạn của con người.

Không chỉ giới hạn trong lãnh vực học thuật, cuốn sách này rất dễ tiếp cận, dễ hiểu và trực quan. Đây không chỉ là một cuốn sách, mà còn là một cuộc phiêu lưu với những câu chuyện thú vị và ví dụ minh họa sống động, giống như bạn đang tham gia vào một cuộc tìm hiểu khoa học hấp dẫn.

“Não Bộ Kể Gì Về Bạn?” không chỉ mở ra cánh cửa để bạn hiểu rõ hơn về bản thân và tâm trí mình, mà còn khơi dậy sự tò mò và khát khao khám phá vô hạn về một phần quan trọng của bản ngã con người – não bộ. Cuốn sách này là lời mời bạn tham gia vào cuộc hành trình khám phá vũ trụ nội tại đầy kỳ diệu và phức tạp.', 1919, '/images/books/Ebook-Nao-bo-ke-gi-ve-ban.jpg', '/books_content/Nao Bo Ke Gi Ve Ban - David Eagleman.epub');
INSERT INTO public.books VALUES (164, ' Đường Ra Biển Lớn', 'Richard Branson', 'Kinh doanh & Tài chính', '“Đường Ra Biển Lớn” không chỉ là một cuốn sách về doanh nhân nổi tiếng Richard Branson, mà còn là một hành trình đầy kỳ diệu qua cuộc sống của một người đàn ông từ những khám phá ồn ào của tuổi thơ đến những thành công rực rỡ trong thế giới kinh doanh.

Trang sách mở ra cánh cửa vào thế giới của Branson từ những ngày đầu tiên, nơi cậu bé tò mò và nghịch ngợm bắt đầu xây dựng những giấc mơ lớn lao. Qua từng trang, ông chia sẻ những chặng đường, từ những thất bại đau đớn đến những bài học quý báu về sự kiên trì và đổi mới.

Branson không chỉ nói về chiến thắng của mình mà còn về những trận thất bại. Ông tập trung vào những giá trị cốt lõi: lòng can đảm, sự sáng tạo, và sự tin tưởng mạnh mẽ vào bản thân. Qua câu chuyện của mình, ông làm rõ rằng con đường tới thành công không bao giờ trải phẳng, nhưng đó cũng chính là nơi nảy sinh những cơ hội lớn.

“Đường Ra Biển Lớn” không chỉ là một cuốn sách về kinh doanh, mà còn là nguồn cảm hứng mạnh mẽ cho những ai đang khao khát theo đuổi ước mơ của mình. Cuốn sách không chỉ đọc về những lý thuyết kinh doanh mà còn về những câu chuyện đời thường, những thất bại và thành công, từ đó tạo ra những bài học quý giá cho độc giả.

Branson không chỉ viết về kinh doanh mà còn về cuộc sống. Cuốn sách không chỉ cho bạn cái nhìn về con đường đến thành công mà còn về sự đam mê, tinh thần phiêu lưu và ý chí kiên định. Đây không chỉ là cuốn sách kể chuyện, mà còn là một bức tranh sống động về cuộc sống và lòng quyết tâm của con người.

“Đường Ra Biển Lớn” không chỉ được đánh giá cao vì những câu chuyện hấp dẫn mà còn vì những bài học sâu sắc. Cuốn sách không chỉ là nguồn cảm hứng mà còn là hướng dẫn cho bạn những bước đi đầu tiên trong việc theo đuổi ước mơ và đạt được thành công.', 1931, '/images/books/bq1fql9q.png', '/books_content/Duong Ra Bien Lon - Richard Branson.epub');
INSERT INTO public.books VALUES (165, ' Lập Trình Ngôn Ngữ Tư Duy', 'Carolyn Boyes', 'Khoa học - Công nghệ', '“Lập Trình Ngôn Ngữ Tư Duy” của Carolyn Boyes không chỉ là một cuốn sách hướng dẫn, mà là một cuộc phiêu lưu sâu sắc vào thế giới tâm lý và tư duy. Trong từng trang sách, tác giả không chỉ chia sẻ về phương pháp NLP mà còn làm thức tỉnh tâm hồn người đọc với những khám phá về bản thân và cuộc sống.

Tác phẩm mở đầu bằng một cánh cửa tâm huyết về NLP, đưa độc giả vào không gian của sự thay đổi và phát triển cá nhân. Bạn không chỉ đọc sách mà còn như bước chân vào một thế giới tư duy mới, nơi mà mọi khía cạnh của cuộc sống có thể được lập trình lại theo cách tích cực.

Các chương trong cuốn sách không chỉ là các đề mục thông thường mà là những hành trình tâm lý, từ việc giới thiệu về NLP đến việc áp dụng nó trong mọi khía cạnh của cuộc sống. Từ cấu trúc của NLP cho đến kỹ năng giao tiếp, tác giả không chỉ trình bày mà còn thấu hiểu sâu sắc về ứng dụng thực tế và tác động lớn của nó đối với tư duy và hành vi con người.

Sự phong phú trong nội dung không chỉ dừng lại ở việc trình bày về lý thuyết NLP mà còn liên kết chặt chẽ với những ví dụ, câu chuyện cuộc sống và những tình huống thực tế. Điều này tạo nên một trải nghiệm đọc độc đáo, khiến cho kiến thức không chỉ trở nên accessible mà còn truyền cảm hứng.

“Lập Trình Ngôn Ngữ Tư Duy” không chỉ là sách dành cho những người muốn nắm bắt kiến thức cơ bản về NLP mà còn là nguồn động viên mạnh mẽ cho những người đang tìm kiếm sự thay đổi tích cực trong cuộc sống. Cuốn sách này không chỉ là hướng dẫn, mà là một cuốn cẩm nang sống đầy năng lượng và sức sống.', 1931, '/images/books/hero__section_11.jpg', '/books_content/Lap Trinh Ngon Ngu Tu Duy - Carolyn Boyes.epub');
INSERT INTO public.books VALUES (166, ' Nghĩ Lớn Để Thành Công', 'Donald J. Trump', 'Lịch sử - Chính trị', 'Nghĩ Lớn Để Thành Công của Donald J. Trump là một tài liệu kinh điển, khám phá tầm vĩ đại của việc mơ ước to lớn để đạt được thành công. Tác giả, một doanh nhân nổi tiếng và chủ tịch của một tập đoàn đa ngành, đã sáng tạo ra một cuốn sách đầy tri thức và khả năng thực hành.

Cuốn sách này không chỉ là một hành trình của sự thành công, mà còn là cuốn hướng dẫn cho những ai muốn trải nghiệm và hiểu cách nghĩ lớn và đạt được ước mơ của mình.

Donald J. Trump không ngần ngại chia sẻ những bài học và những cố gắng của bản thân, từ tư duy lớn mở đầu cho hành động đột phá, từ việc lập kế hoạch tới những cơ hội đàm phán khó khăn. Cuốn sách rút ra tinh hoa từ một cuộc đời thành công và trình bày chúng một cách tổ chức, hấp dẫn và thấu hiểu.

Cuốn sách này đưa ra một triết lý đơn giản nhưng mạnh mẽ về cách nghĩ lớn và hành động. Đó là việc không ngừng học hỏi, không sợ rủi ro, biết cách đàm phán, đoàn kết và lãnh đạo, và biết ơn những gì mà cuộc đời mang lại.

Nếu bạn đang tìm kiếm nguồn cảm hứng và hướng dẫn về cách nghĩ lớn và đạt được thành công, thì cuốn sách này là một hồi chuông đánh thức và đưa ra sự khích lệ. Đừng ngần ngại thảm chí lớn hơn, nghĩ to lớn hơn và hành động to lớn hơn, vì trong những suy nghĩ lớn, bạn sẽ tìm thấy con đường đến thành công.', 1975, '/images/books/Ebook-Nghi-lon-de-thanh-cong.jpg', '/books_content/Nghi Lon De Thanh Cong - Donald J. Trump.epub');
INSERT INTO public.books VALUES (167, 'Siêu Dịch Vụ, Siêu Lợi Nhuận', 'Jeff Gee', 'Kinh doanh & Tài chính', 'Siêu Dịch Vụ, Siêu Lợi Nhuận là một cuốn sách đầy sự bùng nổ về cách tạo ra và duy trì sự xuất sắc trong dịch vụ khách hàng. Tác giả Jeff Gee và Val Gee đã cống hiến cho chúng ta một tác phẩm xuất sắc về việc làm thế nào để biến dịch vụ khách hàng từ một phần của doanh nghiệp thành một yếu tố quyết định đối với thành công.

Điểm đáng chú ý đầu tiên về cuốn sách này chính là sự kinh nghiệm và uy tín của hai tác giả. Jeff và Val Gee không chỉ là người viết sách, mà còn là những chuyên gia hàng đầu về dịch vụ khách hàng. Họ đã thực hiện nhiều dự án thành công và đã giúp hàng ngàn doanh nghiệp cải thiện chất lượng dịch vụ của họ.

Cuốn sách không chỉ đơn giản là một tập hợp các lý thuyết hoặc phương pháp trừu tượng. Thay vào đó, nó mang lại cho bạn một hệ thống cụ thể và chi tiết, từ việc lắng nghe khách hàng, hiểu rõ nhu cầu của họ đến việc tạo ra trải nghiệm khách hàng tuyệt vời. Cuốn sách này không chỉ dựa vào nguyên tắc, mà còn cung cấp cho bạn những hướng dẫn cụ thể để bạn có thể bắt đầu thực hiện ngay lập tức.

Một điểm mạnh nữa của Siêu Dịch Vụ, Siêu Lợi Nhuận chính là cách tác giả sử dụng ngôn ngữ dễ hiểu và tiếp thu. Bạn không cần phải là một chuyên gia về dịch vụ khách hàng để đọc và áp dụng những kiến thức trong cuốn sách này. Từ người quản lý đến nhân viên cơ sở, ai cũng có thể tìm thấy giá trị trong những trang sách này.

Với Siêu Dịch Vụ, Siêu Lợi Nhuận, bạn không chỉ đọc một cuốn sách mà là trải qua một khám phá về cách tạo ra những dịch vụ vượt trội và làm cho khách hàng trở thành những nhà mua hàng trung thành. Cuốn sách này không chỉ là một cuốn sách cần đọc, mà còn là một công cụ quan trọng để nâng cao sự phát triển và thành công của bạn trong thế giới doanh nghiệp ngày nay.', 1988, '/images/books/Ebook-Sieu-dich-vu-sieu-loi-nhuan.jpg', '/books_content/Sieu Dich Vu, Sieu Loi Nhuan - Jeff Gee.epub');
INSERT INTO public.books VALUES (168, 'Lịch Sử Việt Nam', 'Hồ Chí Minh', 'Lịch sử - Chính trị', '“Lịch Sử Việt Nam” của Hồ Chí Minh – Sứ Mệnh Khám Phá Quá Khứ

Cánh cửa của quá khứ đã mở ra, và từng trang sách dường như là một cửa sổ hướng về những hồi ức xa xưa, mang trong mình những ký ức đầy hấp dẫn và thú vị. Cuốn tác phẩm đỉnh cao “Lịch Sử Việt Nam” của Chủ tịch Hồ Chí Minh không chỉ là một bản tường thuật lịch sử khô khan, mà còn là hành trình chân thực xuyên qua các thế kỷ.

Bắt đầu từ những năm 1919, trong bộn bề hoạt động cách mạng tại Pháp, Hồ Chí Minh đã khởi đầu tác phẩm hùng tráng này. Là một tấm gương rực rỡ của sự sáng tạo và kiên trì, ông đã tạo nên một tác phẩm mang tính toàn diện về lịch sử quê hương.

Còn gì thú vị hơn khi cuốn sách này mở ra với những hình ảnh của thời dựng nước, và từng trang viết đưa ta vào cuộc hành trình của Triều đại Hùng Vương – những người cha đầu tiên xây dựng vùng đất núi rừng trở thành một vương quốc. Đương thời, mỗi chương là một cửa sổ vào những thời kỳ lịch sử thăng trầm của dân tộc.

Trong tác phẩm này, lối viết của Hồ Chí Minh trở thành một cánh cửa vạn hoa đưa độc giả vào lòng của mọi sự kiện. Làm thế nào những trận đánh ác liệt, những cuộc chiến tranh và những đợt thăng trầm của quốc gia đã diễn ra – tất cả được trình bày bằng lối văn giản dị, mà tất cả chúng ta có thể hiểu.

Nghệ thuật của cuốn sách này không chỉ dừng lại ở việc kể lịch sử; đó còn là một cách để tạo nên sự kết nối sâu xa giữa quá khứ và hiện tại. Bằng cách kết hợp bút pháp lịch sử với bút pháp văn chương, Hồ Chí Minh đã tạo ra một kiệt tác không chỉ giúp ta tìm hiểu lịch sử, mà còn truyền cảm hứng và thấu hiểu về những gì đã xảy ra.

Là một cuốn sách đẳng cấp, “Lịch Sử Việt Nam” của Hồ Chí Minh không chỉ đưa độc giả vào một hành trình kỳ diệu qua thời gian, mà còn là một lời kêu gọi về những giá trị của quá khứ. Chúng ta không chỉ đọc một cuốn sách, mà còn trải qua một chuyến đi tìm hiểu bản chất vĩnh cửu của quê hương.', 1919, '/images/books/Ebook-Lich-su-Viet-Nam.jpg', '/books_content/Lich Su Viet Nam - Ho Chi Minh.epub');
INSERT INTO public.books VALUES (169, ' Việt Sử Toàn Thư', 'Phạm Văn Sơn', 'Lịch sử - Chính trị', '“Việt Sử Toàn Thư” của Ngô Sĩ Liên không chỉ là một bộ sử liệu quý giá về lịch sử Việt Nam, mà còn là một tác phẩm nghệ thuật đúc kết tinh hoa văn hóa và tri thức của dân tộc. Khi mở cuốn sách, chúng ta như đang mở cánh cửa thời gian, để hòa mình vào những thế kỷ xa xô, những trang sách như những tấm gương phản ánh rõ nét những dấu tích của quá khứ.

Những dòng văn của Ngô Sĩ Liên không chỉ là những sự kể chuyện khô khan, mà là những câu chuyện tinh tế được gói gọn bởi ngôn từ tinh tế, như những viên ngọc lấp lánh. Qua từng trang sách, chúng ta không chỉ đọc về những sự kiện lịch sử, mà còn nhìn thấy con người Việt Nam với những nụ cười, nỗi buồn, đau thương và niềm tự hào.

“Việt Sử Toàn Thư” không chỉ đơn thuần là việc mô tả lịch sử, mà là việc tái hiện lại những trận chiến hùng tráng, những cuộc đối thoại tri thức, và những bản nền văn hóa sâu sắc. Cuốn sách như một bức tranh khổ lớn, mỗi chi tiết là một nét màu tạo nên bức tượng lịch sử phong phú.

Đọc “Việt Sử Toàn Thư,” chúng ta không chỉ cảm nhận được lòng tự hào về quá khứ hào hùng của dân tộc mà còn nhìn thấy sự nghiên cứu sâu rộng, tâm huyết và sự sáng tạo trong lối viết của tác giả. Cuốn sách không chỉ là một tài liệu tham khảo mà còn là một tác phẩm nghệ thuật văn chương đẳng cấp.

Cuối cùng, “Việt Sử Toàn Thư” không chỉ là một cẩm nang lịch sử, mà là một cuộc phiêu lưu tâm hồn, là hành trình đắm chìm vào biển cả kiến thức, để tìm thấy những hiểu biết sâu sắc về bản thân và đất nước.', 1996, '/images/books/35256698443_673049a6d7_o.jpg', '/books_content/Viet Su Toan Thu - Pham Van Son.epub');
INSERT INTO public.books VALUES (170, ' Sát Nhân Mạng', 'Jeffery Deaver', 'Khoa học viễn tưởng & fantasy', 'Sát Nhân Mạng – một tác phẩm đầy tài năng của tác giả Jeffery Deaver, đã đánh bại thời gian và ghi dấu ấn mạnh mẽ trong thế giới trinh thám. Trong một tuyệt tác xuất bản lần đầu vào năm 2022, Jeffery Deaver mang đến một câu chuyện đầy khó hiểu và nghiêm trọng, kéo người đọc vào một vũ trụ trinh thám rộng lớn và nguy hiểm.

Tại trung tâm của cuốn tiểu thuyết là cuộc điều tra phức tạp của hai nhân vật chính, Lincoln Rhyme và Amelia Sachs, về một kẻ giết người hàng loạt tài năng, đang sử dụng công nghệ mạng để truy lùng và thảm sát nạn nhân của mình. Cuộc hành trình đầy căng thẳng này dẫn dắt độc giả qua những lối mòn tinh vi của tâm trí tội phạm và sức mạnh đáng sợ của công nghệ.

Jeffery Deaver không chỉ là một tác giả trinh thám có kinh nghiệm mà còn là một thợ điêu luyện của ngôn ngữ, biến câu chuyện trở nên sâu sắc và đầy tầng lớp. Tác phẩm này không chỉ là việc nối tiếp một loạt các vụ án, mà còn là một bài học về sự tinh tế và năng lực của con người khi đối mặt với tác động của công nghệ và xã hội hiện đại.

Sát Nhân Mạng không chỉ đơn thuần là một tiểu thuyết trinh thám, mà còn là một cuộc khám phá sâu sắc vào tâm hồn con người. Cuốn sách này đưa ra những câu hỏi quan trọng về sự đáng tin cậy của công nghệ, sự riêng tư trên mạng và trách nhiệm của chúng ta đối với sự an toàn của mình. Đó là một tác phẩm trinh thám tinh vi đầy chất lượng, thách thức người đọc không chỉ về kỹ thuật mà còn về đạo đức.

Nếu bạn yêu thích thế giới trinh thám đầy căng thẳng và muốn bị cuốn hút vào một câu chuyện mà bạn không thể đặt xuống, thì Sát Nhân Mạng là một cuốn sách không thể bỏ lỡ. Đây là một tác phẩm nghệ thuật thực sự về tội phạm, công nghệ, và bản chất con người.', 1909, '/images/books/Ebook-Sat-nhan-mang.jpg', '/books_content/Sat Nhan Mang - Jeffery Deaver.epub');
INSERT INTO public.books VALUES (171, 'Giấc Mơ Vàng', 'Nhiều Tác Giả', 'Kỹ năng & Phát triển bản thân', 'Dưới bức tranh màu sắc của chữ viết tinh tế từ tác giả Dũng Phan, “Giấc Mơ Vàng” là một cuốn sách hồi tưởng, vừa là một cuộc phiêu lưu bất tận qua hành trình đầy kịch tính của đội tuyển U23 Việt Nam trong cuộc đua đến với ngôi vương tại SEA Games 2019.

Cuốn sách không phải chỉ là lịch sử kỳ công của bàn thắng vàng, mà là một cuốn hồi ức đầy nhiệt huyết và tình cảm. Tác giả đã dẫn chúng ta lạc vào từng mảng sắc màu của từng trận cầu, nhưng không chỉ dừng lại ở đó. Ông đã đắm mình trong nhịp sống của cầu thủ, nhìn thấy những gì họ thấy, cảm nhận những gì họ cảm nhận. Từ bức họa tư duy, chúng ta như được lắng nghe nhịp đập của trái bóng và rung động trong tâm hồn của từng người.

“Giấc Mơ Vàng” không chỉ là cuốn sách, mà là một cuộc hành trình xuyên qua các cung bậc cảm xúc. Chúng ta không chỉ chứng kiến những pha bóng mãn nhãn, mà còn hiểu hơn về sự kiên trì, quyết tâm và tinh thần đồng đội của mỗi cầu thủ. Đó là những bài học về niềm tin, về việc không ngừng vươn lên dù có khó khăn đến đâu.

Trong từng trang sách, chúng ta cảm nhận được hơi thở của tuổi trẻ, đó là khoảnh khắc tột cùng của đam mê, khi mà họ vẫn còn giữ mãi tinh thần mơ mộng và quả cảm. Chúng ta hòa mình vào không gian của bóng đá, và từ đó, cảm nhận sâu sắc hơn về tình yêu nước, tình đoàn kết và lòng kiên nhẫn.

Nếu bạn đang tìm kiếm một lời động viên, một chút cảm hứng để vươn lên và chinh phục mọi thách thức, thì “Giấc Mơ Vàng” là một hành trang không thể thiếu trên cuộc hành trình của bạn. Cuốn sách là một tấm gương sống động, vẽ nên những nét đẹp của tinh thần thể thao, và truyền cảm hứng cho những người không ngừng nỗ lực theo đuổi ước mơ.', 2019, '/images/books/Ebook-Giac-mo-vang.jpg', '/books_content/Giac Mo Vang - Nhieu tac gia.epub');


--
-- TOC entry 4960 (class 0 OID 16474)
-- Dependencies: 223
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rating VALUES (28, 1, 4, 'AdminTest', 'Harry Potter và Hòn Đá Phù Thủy', 'cuốn sách này rất hay', 3, '2025-04-14 06:34:39.141');
INSERT INTO public.rating VALUES (29, 1, 7, 'AdminTest', 'Mắt Biếc', 'sách này hay thật', 4, '2025-04-14 07:08:23.378');
INSERT INTO public.rating VALUES (31, 1, 9, 'AdminTest', 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'rất hay
', 5, '2025-04-14 16:58:11.613');
INSERT INTO public.rating VALUES (33, 1, 142, 'AdminTest', 'Bán Hàng Cho Những Gã Khổng Lồ', 'Sách hay', 4, '2025-04-15 10:32:04.031');
INSERT INTO public.rating VALUES (34, 1, 142, 'AdminTest', 'Bán Hàng Cho Những Gã Khổng Lồ', 'sách đúng gu tui
', 4, '2025-04-15 10:32:23.669');
INSERT INTO public.rating VALUES (35, 1, 144, 'AdminTest', 'Nghệ Thuật Tư Duy Chiến Lược', 'Sách rất hay cho người tư duy', 4, '2025-04-16 07:22:37.837');
INSERT INTO public.rating VALUES (36, 1, 151, 'AdminTest', 'Tâm Lý Học Dành Cho Lãnh Đạo', 'sách này rất hay', 4, '2025-04-16 10:04:29.018');
INSERT INTO public.rating VALUES (37, 90, 142, 'Trần Thị Bình', 'Bán Hàng Cho Những Gã Khổng Lồ', 'Sách hay, nên đọc', 5, '2025-04-18 11:00:13.066976');
INSERT INTO public.rating VALUES (38, 91, 143, 'Lê Hoàng Châu', 'Thiết lập Internet Vạn Vật Trong Doanh nghiệp', 'Nhiều kiến thức bổ ích', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (39, 92, 7, 'Phạm Thị Diễm', 'Mắt Biếc', 'Cảm động', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (40, 93, 9, 'Vũ Đức Duy', 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'Tuổi thơ ùa về', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (41, 94, 140, 'Đỗ Thị Giang', 'Be Useful: Seven Tools for Life', 'Sách self-help hay', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (42, 95, 4, 'Hoàng Minh Hải', 'Harry Potter và Hòn Đá Phù Thủy', 'Thế giới phép thuật tuyệt vời', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (43, 1, 3, 'AdminTest', '7 Thói Quen Thành Đạt', 'Thay đổi tư duy', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (44, 96, 40, 'Kiều Thị Hương', 'Định luật Murphy', 'Hài hước', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (45, 3, 42, 'user1', 'Nhà Giả Kim', 'Triết lý sâu sắc', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (46, 97, 43, 'Lâm Văn Khang', 'Bố Già', 'Kinh điển', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (47, 98, 44, 'Mai Thị Lan', 'Đắc Nhân Tâm', 'Giao tiếp hiệu quả', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (48, 99, 50, 'Nguyễn Ngọc Minh', 'Yêu Xứ Sở, Thương Đồng Bào', 'Tình yêu quê hương', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (49, 8, 48, 'Huỳnh Văn Vương', 'Thao Túng Tâm Lý', 'Cảnh giác', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (50, 100, 49, 'Phan Văn Nam', '8 Tố Chất Trí Tuệ Quyết Định Cuộc Đời Người Đàn Ông', 'Phát triển bản thân', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (51, 101, 141, 'Quách Thị Oanh', 'Hiểu Về Trái Tim', 'Sâu sắc', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (52, 102, 47, 'Trịnh Xuân Phúc', 'Trạng Quỳnh', 'Hài hước dân gian', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (53, 103, 144, 'Võ Thị Quỳnh', 'Nghệ Thuật Tư Duy Chiến Lược', 'Tư duy chiến lược', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (54, 104, 145, 'Đặng Ngọc Sơn', 'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 'Nhớ về tuổi thơ', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (55, 13, 147, 'Nguyễn Văn An', 'Peter Pan', 'Thế giới diệu kỳ', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (56, 105, 149, 'Hà Thu Thủy', 'Dế Mèn Phiêu Lưu Ký', 'Phiêu lưu hấp dẫn', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (57, 106, 150, 'Cao Văn Tiến', 'Hoàng Tử Bé', 'Ý nghĩa cuộc sống', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (58, 107, 151, 'Bùi Thị Uyên', 'Tâm Lý Học Dành Cho Lãnh Đạo', 'Lãnh đạo hiệu quả', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (59, 108, 152, 'Dương Minh Vương', 'Đàn Ông Sao Hỏa, Đàn Bà Sao Kim', 'Tình yêu và hôn nhân', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (60, 109, 154, 'Nguyễn Thị Xuân', 'Trở Về Từ Xứ Tuyết', 'Hồi hộp', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (61, 110, 155, 'Trần Văn Ý', 'Từng Qua Tuổi 20', 'Tuổi trẻ', 4, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (62, 111, 156, 'Lê Thị Ánh', 'Những Bước Đơn Giản Đến Ước Mơ', 'Động lực', 4, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (63, 112, 157, 'Phạm Hoàng Bách', 'Luyện trí nhớ', 'Cải thiện trí nhớ', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (64, 113, 158, 'Vũ Thị Cẩm', 'Muôn Kiếp Nhân Sinh', 'Luân hồi', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (65, 114, 159, 'Đỗ Đức Chính', 'Tại Sao Chúng Ta Không Hạnh Phúc?', 'Tìm kiếm hạnh phúc', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (66, 115, 160, 'Hoàng Thị Dung', 'Tôi Tài Giỏi, Bạn Cũng Thế', 'Truyền cảm hứng', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (67, 116, 142, 'Kiều Văn Em', 'Bán Hàng Cho Những Gã Khổng Lồ', 'Bí quyết bán hàng', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (68, 117, 143, 'Lâm Thị Gấm', 'Thiết lập Internet Vạn Vật Trong Doanh nghiệp', 'IoT trong kinh doanh', 4, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (69, 118, 7, 'Mai Ngọc Hà', 'Mắt Biếc', 'Tình yêu buồn', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (70, 119, 9, 'Nguyễn Phi Hùng', 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'Ký ức tuổi thơ', 4, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (71, 120, 140, 'Phan Thị Hương', 'Be Useful: Seven Tools for Life', 'Công cụ cuộc sống', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (72, 121, 4, 'Quách Xuân Kiên', 'Harry Potter và Hòn Đá Phù Thủy', 'Phiêu lưu kỳ thú', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (73, 122, 3, 'Trịnh Thị Loan', '7 Thói Quen Thành Đạt', 'Thói quen thành công', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (74, 123, 40, 'Võ Văn Mạnh', 'Định luật Murphy', 'Hài hước về cuộc sống', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (75, 124, 42, 'Đặng Thị Nga', 'Nhà Giả Kim', 'Hành trình tìm kiếm', 4, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (76, 125, 43, 'Hà Ngọc Oanh', 'Bố Già', 'Mafia Ý', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (77, 126, 44, 'Cao Thị Phương', 'Đắc Nhân Tâm', 'Nghệ thuật giao tiếp', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (78, 127, 50, 'Bùi Văn Quang', 'Yêu Xứ Sở, Thương Đồng Bào', 'Tình yêu nước', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (79, 128, 48, 'Dương Thị Quỳnh', 'Thao Túng Tâm Lý', 'Hiểu rõ tâm lý', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (80, 129, 49, 'Nguyễn Xuân Sơn', '8 Tố Chất Trí Tuệ Quyết Định Cuộc Đời Người Đàn Ông', 'Phẩm chất đàn ông', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (81, 130, 141, 'Trần Thị Thanh', 'Hiểu Về Trái Tim', 'Cảm xúc con người', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (82, 131, 47, 'Lê Văn Thắng', 'Trạng Quỳnh', 'Truyện cười dân gian', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (83, 132, 144, 'Phạm Thị Thảo', 'Nghệ Thuật Tư Duy Chiến Lược', 'Chiến lược thành công', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (84, 133, 145, 'Vũ Đức Thịnh', 'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 'Vé về tuổi thơ', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (85, 134, 147, 'Đỗ Thị Thu', 'Peter Pan', 'Hòn đảo thần tiên', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (86, 135, 149, 'Hoàng Minh Tiến', 'Dế Mèn Phiêu Lưu Ký', 'Cuộc phiêu lưu của Dế Mèn', 4, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (87, 136, 150, 'Kiều Thị Trang', 'Hoàng Tử Bé', 'Chuyến phiêu lưu của Hoàng Tử Bé', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (88, 137, 151, 'Lâm Văn Tú', 'Tâm Lý Học Dành Cho Lãnh Đạo', 'Bí quyết lãnh đạo', 5, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (89, 138, 152, 'Mai Thị Tuyết', 'Đàn Ông Sao Hỏa, Đàn Bà Sao Kim', 'Khác biệt giới tính', 4, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (90, 139, 154, 'Nguyễn Ngọc Uyên', 'Trở Về Từ Xứ Tuyết', 'Hành trình trở về', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (91, 140, 155, 'Phan Văn Việt', 'Từng Qua Tuổi 20', 'Suy nghĩ về tuổi 20', 2, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (92, 141, 156, 'Quách Thị Xuân', 'Những Bước Đơn Giản Đến Ước Mơ', 'Đạt được ước mơ', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (93, 142, 157, 'Trịnh Xuân Yên', 'Luyện trí nhớ', 'Phương pháp luyện trí nhớ', 1, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (94, 143, 158, 'Võ Thị Ý', 'Muôn Kiếp Nhân Sinh', 'Nhân quả', 4, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (95, 144, 159, 'Đặng Ngọc Ánh', 'Tại Sao Chúng Ta Không Hạnh Phúc?', 'Đi tìm hạnh phúc', 3, '2025-04-18 11:01:13.383488');
INSERT INTO public.rating VALUES (96, 90, 142, 'Trần Thị Bình', 'Bán Hàng Cho Những Gã Khổng Lồ', 'Sách hay về bán hàng.', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (97, 91, 143, 'Lê Hoàng Châu', 'Thiết lập Internet Vạn Vật Trong Doanh nghiệp', 'Sách chuyên ngành IoT.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (98, 92, 7, 'Phạm Thị Diễm', 'Mắt Biếc', 'Truyện tình cảm sâu sắc.', 3, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (99, 93, 9, 'Vũ Đức Duy', 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'Tuổi thơ êm đềm.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (100, 94, 140, 'Đỗ Thị Giang', 'Be Useful: Seven Tools for Life', 'Sách self-help hữu ích.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (101, 95, 4, 'Hoàng Minh Hải', 'Harry Potter và Hòn Đá Phù Thủy', 'Thế giới phép thuật kỳ diệu.', 5, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (102, 1, 3, 'AdminTest', '7 Thói Quen Thành Đạt', 'Sách kinh điển về phát triển bản thân.', 5, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (103, 96, 40, 'Kiều Thị Hương', 'Định luật Murphy', 'Sách hài hước về những điều xui xẻo.', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (104, 3, 42, 'user1', 'Nhà Giả Kim', 'Hành trình tìm kiếm ước mơ.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (105, 97, 43, 'Lâm Văn Khang', 'Bố Già', 'Tiểu thuyết tội phạm kinh điển.', 5, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (106, 98, 44, 'Mai Thị Lan', 'Đắc Nhân Tâm', 'Sách về nghệ thuật giao tiếp.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (107, 99, 50, 'Nguyễn Ngọc Minh', 'Yêu Xứ Sở, Thương Đồng Bào', 'Tình yêu quê hương đất nước.', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (108, 8, 48, 'Huỳnh Văn Vương', 'Thao Túng Tâm Lý', 'Sách về tâm lý học.', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (109, 100, 49, 'Phan Văn Nam', '8 Tố Chất Trí Tuệ Quyết Định Cuộc Đời Người Đàn Ông', 'Sách phát triển bản thân cho nam giới.', 3, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (110, 101, 141, 'Quách Thị Oanh', 'Hiểu Về Trái Tim', 'Sách về tâm lý học tình yêu.', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (111, 102, 47, 'Trịnh Xuân Phúc', 'Trạng Quỳnh', 'Truyện hài dân gian.', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (112, 103, 144, 'Võ Thị Quỳnh', 'Nghệ Thuật Tư Duy Chiến Lược', 'Sách về chiến lược kinh doanh.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (113, 104, 145, 'Đặng Ngọc Sơn', 'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 'Truyện dài của Nguyễn Nhật Ánh.', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (114, 13, 147, 'Nguyễn Văn An', 'Peter Pan', 'Câu chuyện về cậu bé không lớn.', 3, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (115, 105, 149, 'Hà Thu Thủy', 'Dế Mèn Phiêu Lưu Ký', 'Truyện phiêu lưu của nhà văn Tô Hoài.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (116, 106, 150, 'Cao Văn Tiến', 'Hoàng Tử Bé', 'Truyện ngụ ngôn sâu sắc.', 5, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (117, 107, 151, 'Bùi Thị Uyên', 'Tâm Lý Học Dành Cho Lãnh Đạo', 'Sách về tâm lý học quản lý.', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (118, 108, 152, 'Dương Minh Vương', 'Đàn Ông Sao Hỏa, Đàn Bà Sao Kim', 'Sách về mối quan hệ nam nữ.', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (119, 109, 154, 'Nguyễn Thị Xuân', 'Trở Về Từ Xứ Tuyết', 'Tiểu thuyết lãng mạn.', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (120, 110, 155, 'Trần Văn Ý', 'Từng Qua Tuổi 20', 'Sách dành cho người trẻ.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (121, 111, 156, 'Lê Thị Ánh', 'Những Bước Đơn Giản Đến Ước Mơ', 'Sách truyền cảm hứng.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (122, 112, 157, 'Phạm Hoàng Bách', 'Luyện trí nhớ', 'Sách về phương pháp học tập.', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (123, 113, 158, 'Vũ Thị Cẩm', 'Muôn Kiếp Nhân Sinh', 'Sách về tâm linh và luân hồi.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (124, 114, 159, 'Đỗ Đức Chính', 'Tại Sao Chúng Ta Không Hạnh Phúc?', 'Sách về triết học và hạnh phúc.', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (125, 115, 160, 'Hoàng Thị Dung', 'Tôi Tài Giỏi, Bạn Cũng Thế', 'Sách về phương pháp học tập hiệu quả.', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (126, 116, 142, 'Kiều Văn Em', 'Bán Hàng Cho Những Gã Khổng Lồ', 'Sách này rất hay', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (127, 117, 143, 'Lâm Thị Gấm', 'Thiết lập Internet Vạn Vật Trong Doanh nghiệp', 'Sách này khá là hay', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (128, 118, 7, 'Mai Ngọc Hà', 'Mắt Biếc', 'Tôi thích quyển sách này', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (129, 119, 9, 'Nguyễn Phi Hùng', 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'Sách này đọc khá ổn', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (130, 120, 140, 'Phan Thị Hương', 'Be Useful: Seven Tools for Life', 'Sách này rất bổ ích', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (131, 121, 4, 'Quách Xuân Kiên', 'Harry Potter và Hòn Đá Phù Thủy', 'Sách này tuyệt vời', 5, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (132, 122, 3, 'Trịnh Thị Loan', '7 Thói Quen Thành Đạt', 'Sách này đáng đọc', 5, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (133, 123, 40, 'Võ Văn Mạnh', 'Định luật Murphy', 'Sách này hài hước', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (134, 124, 42, 'Đặng Thị Nga', 'Nhà Giả Kim', 'Sách này ý nghĩa', 5, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (135, 125, 43, 'Hà Ngọc Oanh', 'Bố Già', 'Sách này hay', 3, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (136, 126, 44, 'Cao Thị Phương', 'Đắc Nhân Tâm', 'Sách này bổ ích', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (137, 127, 50, 'Bùi Văn Quang', 'Yêu Xứ Sở, Thương Đồng Bào', 'Sách này cảm động', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (138, 128, 48, 'Dương Thị Quỳnh', 'Thao Túng Tâm Lý', 'Sách này thú vị', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (139, 129, 49, 'Nguyễn Xuân Sơn', '8 Tố Chất Trí Tuệ Quyết Định Cuộc Đời Người Đàn Ông', 'Sách này đáng để đọc', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (140, 130, 141, 'Trần Thị Thanh', 'Hiểu Về Trái Tim', 'Sách này hay', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (141, 131, 47, 'Lê Văn Thắng', 'Trạng Quỳnh', 'Sách này hài hước', 3, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (142, 132, 144, 'Phạm Thị Thảo', 'Nghệ Thuật Tư Duy Chiến Lược', 'Sách này đáng để đọc', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (143, 133, 145, 'Vũ Đức Thịnh', 'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 'Sách này cảm động', 3, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (144, 134, 147, 'Đỗ Thị Thu', 'Peter Pan', 'Sách này hay', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (145, 135, 149, 'Hoàng Minh Tiến', 'Dế Mèn Phiêu Lưu Ký', 'Sách này phiêu lưu', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (146, 136, 150, 'Kiều Thị Trang', 'Hoàng Tử Bé', 'Sách này ý nghĩa', 3, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (147, 137, 151, 'Lâm Văn Tú', 'Tâm Lý Học Dành Cho Lãnh Đạo', 'Sách này đáng để đọc', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (148, 138, 152, 'Mai Thị Tuyết', 'Đàn Ông Sao Hỏa, Đàn Bà Sao Kim', 'Sách này thú vị', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (149, 139, 154, 'Nguyễn Ngọc Uyên', 'Trở Về Từ Xứ Tuyết', 'Sách này lãng mạn', 4, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (150, 140, 155, 'Phan Văn Việt', 'Từng Qua Tuổi 20', 'Sách này dành cho người trẻ', 1, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (151, 141, 156, 'Quách Thị Xuân', 'Những Bước Đơn Giản Đến Ước Mơ', 'Sách này truyền cảm hứng', 2, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (152, 142, 157, 'Trịnh Xuân Yên', 'Luyện trí nhớ', 'Sách này về phương pháp học tập', 5, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (153, 143, 158, 'Võ Thị Ý', 'Muôn Kiếp Nhân Sinh', 'Sách này về tâm linh', 3, '2025-04-18 11:07:20.527532');
INSERT INTO public.rating VALUES (154, 90, 142, 'Trần Thị Bình', 'Bán Hàng Cho Những Gã Khổng Lồ', 'Cuốn sách này cung cấp nhiều kiến thức bổ ích về bán hàng.', 5, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (155, 91, 143, 'Lê Hoàng Châu', 'Thiết lập Internet Vạn Vật Trong Doanh nghiệp', 'Sách hay về IoT trong doanh nghiệp, đáng đọc.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (156, 92, 7, 'Phạm Thị Diễm', 'Mắt Biếc', 'Một câu chuyện tình buồn và sâu lắng.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (157, 93, 9, 'Vũ Đức Duy', 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'Tuổi thơ êm đềm và những kỷ niệm khó quên.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (158, 94, 140, 'Đỗ Thị Giang', 'Be Useful: Seven Tools for Life', 'Sách self-help rất hay, đáng để nghiền ngẫm.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (159, 95, 4, 'Hoàng Minh Hải', 'Harry Potter và Hòn Đá Phù Thủy', 'Thế giới phép thuật đầy mê hoặc và hấp dẫn.', 3, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (160, 1, 3, 'AdminTest', '7 Thói Quen Thành Đạt', 'Cuốn sách kinh điển về phát triển bản thân.', 5, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (161, 96, 40, 'Kiều Thị Hương', 'Định luật Murphy', 'Sách hài hước về những điều xui xẻo trong cuộc sống.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (162, 3, 42, 'user1', 'Nhà Giả Kim', 'Một câu chuyện về hành trình tìm kiếm ước mơ.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (163, 97, 43, 'Lâm Văn Khang', 'Bố Già', 'Cuốn tiểu thuyết kinh điển về thế giới mafia.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (164, 98, 44, 'Mai Thị Lan', 'Đắc Nhân Tâm', 'Sách hay về nghệ thuật giao tiếp và ứng xử.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (165, 99, 50, 'Nguyễn Ngọc Minh', 'Yêu Xứ Sở, Thương Đồng Bào', 'Tình yêu quê hương đất nước tha thiết.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (166, 8, 48, 'Huỳnh Văn Vương', 'Thao Túng Tâm Lý', 'Sách giúp hiểu rõ hơn về các chiêu trò tâm lý.', 3, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (167, 100, 49, 'Phan Văn Nam', '8 Tố Chất Trí Tuệ Quyết Định Cuộc Đời Người Đàn Ông', 'Sách này rất đáng đọc để phát triển bản thân.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (168, 101, 141, 'Quách Thị Oanh', 'Hiểu Về Trái Tim', 'Cuốn sách giúp ta hiểu rõ hơn về cảm xúc.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (169, 102, 47, 'Trịnh Xuân Phúc', 'Trạng Quỳnh', 'Những câu chuyện hài hước và thông minh.', 3, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (170, 103, 144, 'Võ Thị Quỳnh', 'Nghệ Thuật Tư Duy Chiến Lược', 'Sách hay về tư duy chiến lược trong kinh doanh.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (171, 104, 145, 'Đặng Ngọc Sơn', 'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 'Tác phẩm gợi nhớ về những kỷ niệm tuổi thơ.', 3, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (172, 13, 147, 'Nguyễn Văn An', 'Peter Pan', 'Câu chuyện về cậu bé không bao giờ lớn.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (173, 105, 149, 'Hà Thu Thủy', 'Dế Mèn Phiêu Lưu Ký', 'Cuộc phiêu lưu đầy thú vị của Dế Mèn.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (174, 106, 150, 'Cao Văn Tiến', 'Hoàng Tử Bé', 'Câu chuyện triết lý sâu sắc và đầy ý nghĩa.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (175, 107, 151, 'Bùi Thị Uyên', 'Tâm Lý Học Dành Cho Lãnh Đạo', 'Sách giúp ích cho những người làm lãnh đạo.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (176, 108, 152, 'Dương Minh Vương', 'Đàn Ông Sao Hỏa, Đàn Bà Sao Kim', 'Sách về sự khác biệt giữa đàn ông và phụ nữ.', 5, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (177, 109, 154, 'Nguyễn Thị Xuân', 'Trở Về Từ Xứ Tuyết', 'Cuốn tiểu thuyết lãng mạn và đầy cảm xúc.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (178, 110, 155, 'Trần Văn Ý', 'Từng Qua Tuổi 20', 'Sách dành cho những người trẻ đang bước vào đời.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (179, 111, 156, 'Lê Thị Ánh', 'Những Bước Đơn Giản Đến Ước Mơ', 'Sách truyền cảm hứng theo đuổi ước mơ.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (180, 112, 157, 'Phạm Hoàng Bách', 'Luyện trí nhớ', 'Sách hướng dẫn các phương pháp luyện trí nhớ.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (181, 113, 158, 'Vũ Thị Cẩm', 'Muôn Kiếp Nhân Sinh', 'Cuốn sách về luật nhân quả và luân hồi.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (182, 114, 159, 'Đỗ Đức Chính', 'Tại Sao Chúng Ta Không Hạnh Phúc?', 'Sách giúp ta tìm hiểu về nguyên nhân của nỗi bất hạnh.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (183, 115, 160, 'Hoàng Thị Dung', 'Tôi Tài Giỏi, Bạn Cũng Thế', 'Sách truyền động lực và phương pháp học tập hiệu quả.', 5, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (184, 116, 142, 'Kiều Văn Em', 'Bán Hàng Cho Những Gã Khổng Lồ', 'Đây là một cuốn sách tuyệt vời về bán hàng.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (185, 117, 143, 'Lâm Thị Gấm', 'Thiết lập Internet Vạn Vật Trong Doanh nghiệp', 'Tôi đã học được rất nhiều điều từ cuốn sách này.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (186, 118, 7, 'Mai Ngọc Hà', 'Mắt Biếc', 'Cuốn sách này khiến tôi nhớ về mối tình đầu của mình.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (187, 119, 9, 'Nguyễn Phi Hùng', 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'Đây là một cuốn sách rất hay về tuổi thơ.', 3, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (188, 120, 140, 'Phan Thị Hương', 'Be Useful: Seven Tools for Life', 'Cuốn sách này đã thay đổi cuộc đời tôi.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (189, 121, 4, 'Quách Xuân Kiên', 'Harry Potter và Hòn Đá Phù Thủy', 'Tôi rất thích thế giới phép thuật trong cuốn sách này.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (190, 122, 3, 'Trịnh Thị Loan', '7 Thói Quen Thành Đạt', 'Cuốn sách này giúp tôi trở nên thành công hơn.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (191, 123, 40, 'Võ Văn Mạnh', 'Định luật Murphy', 'Cuốn sách này rất hài hước và thú vị.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (192, 124, 42, 'Đặng Thị Nga', 'Nhà Giả Kim', 'Đây là một câu chuyện rất hay về ước mơ.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (193, 125, 43, 'Hà Ngọc Oanh', 'Bố Già', 'Cuốn tiểu thuyết này rất hấp dẫn và gây cấn.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (194, 126, 44, 'Cao Thị Phương', 'Đắc Nhân Tâm', 'Cuốn sách này giúp tôi cải thiện kỹ năng giao tiếp.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (195, 127, 50, 'Bùi Văn Quang', 'Yêu Xứ Sở, Thương Đồng Bào', 'Cuốn sách này thể hiện tình yêu quê hương sâu sắc.', 5, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (196, 128, 48, 'Dương Thị Quỳnh', 'Thao Túng Tâm Lý', 'Cuốn sách này giúp tôi hiểu rõ hơn về tâm lý con người.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (197, 129, 49, 'Nguyễn Xuân Sơn', '8 Tố Chất Trí Tuệ Quyết Định Cuộc Đời Người Đàn Ông', 'Cuốn sách này rất đáng để đọc và suy ngẫm.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (198, 130, 141, 'Trần Thị Thanh', 'Hiểu Về Trái Tim', 'Cuốn sách này giúp tôi hiểu rõ hơn về cảm xúc của mình.', 5, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (199, 131, 47, 'Lê Văn Thắng', 'Trạng Quỳnh', 'Những câu chuyện về Trạng Quỳnh rất hài hước và thông minh.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (200, 132, 144, 'Phạm Thị Thảo', 'Nghệ Thuật Tư Duy Chiến Lược', 'Cuốn sách này giúp tôi tư duy chiến lược hơn trong công việc.', 3, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (201, 133, 145, 'Vũ Đức Thịnh', 'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 'Cuốn sách này đưa tôi trở về tuổi thơ với những kỷ niệm đẹp.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (202, 134, 147, 'Đỗ Thị Thu', 'Peter Pan', 'Câu chuyện về Peter Pan rất kỳ diệu và hấp dẫn.', 4, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (203, 135, 149, 'Hoàng Minh Tiến', 'Dế Mèn Phiêu Lưu Ký', 'Cuộc phiêu lưu của Dế Mèn rất thú vị và bổ ích.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (204, 136, 150, 'Kiều Thị Trang', 'Hoàng Tử Bé', 'Cuốn sách này có nhiều bài học sâu sắc về cuộc sống.', 3, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (205, 137, 151, 'Lâm Văn Tú', 'Tâm Lý Học Dành Cho Lãnh Đạo', 'Cuốn sách này giúp tôi hiểu rõ hơn về tâm lý lãnh đạo.', 1, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (206, 138, 152, 'Mai Thị Tuyết', 'Đàn Ông Sao Hỏa, Đàn Bà Sao Kim', 'Cuốn sách này giúp tôi hiểu rõ hơn về sự khác biệt giữa đàn ông và phụ nữ.', 2, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (207, 139, 154, 'Nguyễn Ngọc Uyên', 'Trở Về Từ Xứ Tuyết', 'Cuốn tiểu thuyết này rất lãng mạn và cảm động.', 3, '2025-04-18 11:11:13.638048');
INSERT INTO public.rating VALUES (208, 140, 155, 'Phan Văn Việt', 'Từng Qua Tuổi 20', 'Cuốn sách này dành cho những người trẻ đang bước vào đời, rất hay.', 1, '2025-04-18 11:11:13.638048');


--
-- TOC entry 4961 (class 0 OID 16497)
-- Dependencies: 224
-- Data for Name: slider; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.slider VALUES (1, '/slider/city.jpg', '/slider/nature.jpg', '/slider/technology.jpg', NULL);


--
-- TOC entry 4958 (class 0 OID 16432)
-- Dependencies: 221
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (90, 'Trần Thị Bình', 'tranthibinh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (91, 'Lê Hoàng Châu', 'lehoangchau@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (92, 'Phạm Thị Diễm', 'phamthidiem@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (93, 'Vũ Đức Duy', 'vuducduy@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (94, 'Đỗ Thị Giang', 'dothigiang@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (95, 'Hoàng Minh Hải', 'hoangminhhai@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (1, 'AdminTest', 'admin@gmail.com', '$2b$10$DVCnChUtpFfMCvKwg8ih2OJxmxZ46oa4fjX1mc3mxie.dk8QEtrUC', 'admin');
INSERT INTO public.users VALUES (96, 'Kiều Thị Hương', 'kieuthihuong@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (3, 'user1', 'test@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (97, 'Lâm Văn Khang', 'lamvankhang@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (98, 'Mai Thị Lan', 'maithilan@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (99, 'Nguyễn Ngọc Minh', 'nguyenngocminh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (8, 'Huỳnh Văn Vương', 'huynhvanvuuong0203@gmail.com', '$2b$10$3uM5.3hh07dKX4Ll9KXUd.lW4oS71ZhTKyQAD.p/yKP4BLomajwpG', 'user');
INSERT INTO public.users VALUES (100, 'Phan Văn Nam', 'phanvannam@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (101, 'Quách Thị Oanh', 'quachthioanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (102, 'Trịnh Xuân Phúc', 'trinhxuanphuc@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (103, 'Võ Thị Quỳnh', 'vothiquynh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (104, 'Đặng Ngọc Sơn', 'dangngocson@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (13, 'Nguyễn Văn An', 'nguyenvanan@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (105, 'Hà Thu Thủy', 'hathuthuy@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (106, 'Cao Văn Tiến', 'caovantien@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (107, 'Bùi Thị Uyên', 'buithiyuen@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (108, 'Dương Minh Vương', 'duongminhvuong@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (109, 'Nguyễn Thị Xuân', 'nguyenthixuan@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (110, 'Trần Văn Ý', 'tranvany@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (111, 'Lê Thị Ánh', 'lethianh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (112, 'Phạm Hoàng Bách', 'phamhoangbach@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (113, 'Vũ Thị Cẩm', 'vuthicam@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (114, 'Đỗ Đức Chính', 'doducchinh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (115, 'Hoàng Thị Dung', 'hoangthidung@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (116, 'Kiều Văn Em', 'kieuvanem@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (117, 'Lâm Thị Gấm', 'lamthigam@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (118, 'Mai Ngọc Hà', 'maingochha@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (119, 'Nguyễn Phi Hùng', 'nguyenphihung@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (120, 'Phan Thị Hương', 'phanthihuong@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (121, 'Quách Xuân Kiên', 'quachxuankien@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (122, 'Trịnh Thị Loan', 'trinhthiloan@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (123, 'Võ Văn Mạnh', 'vovanmanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (124, 'Đặng Thị Nga', 'dangthinga@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (125, 'Hà Ngọc Oanh', 'hangocoanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (126, 'Cao Thị Phương', 'caothiphuong@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (127, 'Bùi Văn Quang', 'buivanquang@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (128, 'Dương Thị Quỳnh', 'duongthiquynh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (129, 'Nguyễn Xuân Sơn', 'nguyenxuanson@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (130, 'Trần Thị Thanh', 'tranthithanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (131, 'Lê Văn Thắng', 'levanthang@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (132, 'Phạm Thị Thảo', 'phamthithao@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (133, 'Vũ Đức Thịnh', 'vuducthinh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (134, 'Đỗ Thị Thu', 'dothithu@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (135, 'Hoàng Minh Tiến', 'hoangminhtien@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (136, 'Kiều Thị Trang', 'kieuthitrang@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (137, 'Lâm Văn Tú', 'lamvantu@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (138, 'Mai Thị Tuyết', 'maithituyet@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (139, 'Nguyễn Ngọc Uyên', 'nguyenngocuyen@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (140, 'Phan Văn Việt', 'phanvanviet@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (141, 'Quách Thị Xuân', 'quachthixuan@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (142, 'Trịnh Xuân Yên', 'trinhxuanyen@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (143, 'Võ Thị Ý', 'vothiy@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (144, 'Đặng Ngọc Ánh', 'dangngocanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (145, 'Hà Thu Ba', 'hathuba@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (146, 'Cao Văn Bảo', 'caovanbao@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (147, 'Bùi Thị Bích', 'buithibich@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (148, 'Dương Minh Cường', 'duongminhcuong@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (149, 'Nguyễn Thị Dung', 'nguyenthidung@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (150, 'Trần Văn Đức', 'tranvanduc@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (151, 'Lê Thị Hà', 'lethiha@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (152, 'Phạm Hoàng Hải', 'phamhoanghai@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (153, 'Vũ Thị Hiền', 'vuthihien@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (154, 'Đỗ Đức Hòa', 'doduchoa@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (155, 'Hoàng Thị Hương', 'hoangthihuong@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (156, 'Kiều Văn Khang', 'kieuvankhang@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (157, 'Lâm Thị Kiều', 'lamthikieu@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (158, 'Mai Ngọc Lan', 'maingoclan@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (159, 'Nguyễn Phi Long', 'nguyenphilong@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (160, 'Phan Thị Loan', 'phanthiloan@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (161, 'Quách Xuân Mạnh', 'quachxuanmanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (162, 'Trịnh Thị Mỹ', 'trinhthimy@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (163, 'Võ Văn Nam', 'vovannam@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (164, 'Đặng Thị Ngọc', 'dangthingoc@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (165, 'Cao Thị Phương Anh', 'caothiphuonganh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (166, 'Bùi Văn Quang Anh', 'buivanquanganh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (167, 'Dương Thị Quỳnh Anh', 'duongthiquynhanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (168, 'Nguyễn Xuân Sơn Anh', 'nguyenxuansonanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (169, 'Trần Thị Thanh Anh', 'tranthithanhanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (170, 'Lê Văn Thắng Anh', 'levanthanganh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (171, 'Phạm Thị Thảo Anh', 'phamthithaoanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (172, 'Vũ Đức Thịnh Anh', 'vuducthinhanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (173, 'Đỗ Thị Thu Anh', 'dothithuanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (174, 'Hoàng Minh Tiến Anh', 'hoangminhtienanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (175, 'Kiều Thị Trang Anh', 'kieuthitranganh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (176, 'Lâm Văn Tú Anh', 'lamvantuahnh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (177, 'Mai Thị Tuyết Anh', 'maithituyetanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (178, 'Nguyễn Ngọc Uyên Anh', 'nguyenngocuyenanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (179, 'Phan Văn Việt Anh', 'phanvanvietanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (180, 'Quách Thị Xuân Anh', 'quachthixuananh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (181, 'Trịnh Xuân Yên Anh', 'trinhxuanyenanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (182, 'Võ Thị Ý Anh', 'vothiyanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (183, 'Đặng Ngọc Ánh Anh', 'dangngocanhanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (184, 'Hà Thu Ba Anh', 'hathubaanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (185, 'Cao Văn Bảo Anh', 'caovanbaoanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (186, 'Bùi Thị Bích Anh', 'buithibichanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (187, 'Dương Minh Cường Anh', 'duongminhcuonganh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (188, 'Nguyễn Thị Dung Anh', 'nguyenthidunganh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (189, 'Trần Văn Đức Anh', 'tranvanducanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (190, 'Lê Thị Hà Anh', 'lethihanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (191, 'Phạm Hoàng Hải Anh', 'phamhoanghaianh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (192, 'Vũ Thị Hiền Anh', 'vuthihienanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (193, 'Đỗ Đức Hòa Anh', 'doduchoaanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (194, 'Hoàng Thị Hương Anh', 'hoangthihuonganh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (195, 'Kiều Văn Khang Anh', 'kieuvankhanganh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (196, 'Lâm Thị Kiều Anh', 'lamthikieuanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (197, 'Mai Ngọc Lan Anh', 'maingoclananh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (198, 'Nguyễn Phi Long Anh', 'nguyenphilonganh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (199, 'Phan Thị Loan Anh', 'phanthiloananh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');
INSERT INTO public.users VALUES (200, 'Quách Xuân Mạnh Anh', 'quachxuanmanhanh@gmail.com', '$2b$10$x1Ry1LHb6GSXfN/t.leUc.p8nWIcpN43Pl4l9YZ4oY4Rr9UoKipwa', 'user');


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 227
-- Name: audio_books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audio_books_id_seq', 9, true);


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 225
-- Name: book_views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_views_id_seq', 38, true);


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 218
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 171, true);


--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 222
-- Name: rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rating_id_seq', 208, true);


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 200, true);


--
-- TOC entry 4806 (class 2606 OID 16585)
-- Name: audio_books audio_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audio_books
    ADD CONSTRAINT audio_books_pkey PRIMARY KEY (id);


--
-- TOC entry 4804 (class 2606 OID 16541)
-- Name: book_views book_views_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_views
    ADD CONSTRAINT book_views_pkey PRIMARY KEY (id);


--
-- TOC entry 4794 (class 2606 OID 16421)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 4800 (class 2606 OID 16483)
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (id);


--
-- TOC entry 4802 (class 2606 OID 16503)
-- Name: slider slider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.slider
    ADD CONSTRAINT slider_pkey PRIMARY KEY (id);


--
-- TOC entry 4796 (class 2606 OID 16441)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4798 (class 2606 OID 16439)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4809 (class 2606 OID 16542)
-- Name: book_views book_views_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_views
    ADD CONSTRAINT book_views_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id);


--
-- TOC entry 4807 (class 2606 OID 16489)
-- Name: rating rating_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- TOC entry 4808 (class 2606 OID 16484)
-- Name: rating rating_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2025-06-06 10:10:57

--
-- PostgreSQL database dump complete
--

