PGDMP                       |            library    16.1    16.0 5    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16397    library    DATABASE     �   CREATE DATABASE library WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE library;
                postgres    false            �            1255    16535    DelBook(bigint) 	   PROCEDURE     =  CREATE PROCEDURE public."DelBook"(IN "PID" bigint)
    LANGUAGE plpgsql
    AS $$DECLARE k integer;
BEGIN
	SELECT COUNT(*) FROM reader_book
	WHERE book_id = "PID" into k;
	IF (k=0) THEN
    	DELETE FROM book WHERE ID = "PID"; 
	ELSE
		RAISE NOTICE 'Такой книги не существует!';
		END IF;
END$$;
 2   DROP PROCEDURE public."DelBook"(IN "PID" bigint);
       public          postgres    false            �            1255    16537    DelCategory(bigint) 	   PROCEDURE     E  CREATE PROCEDURE public."DelCategory"(IN "PID" bigint)
    LANGUAGE plpgsql
    AS $$declare k integer;
BEGIN
	SELECT COUNT(*) FROM book
	WHERE category_id = "PID" into k;
	IF (k=0) THEN
		DELETE FROM category WHERE ID = "PID"; 
	ELSE
		RAISE NOTICE 'Такого раздела не существует!';
	END IF;
END $$;
 6   DROP PROCEDURE public."DelCategory"(IN "PID" bigint);
       public          postgres    false            �            1255    16536    DelReader(bigint) 	   PROCEDURE     �   CREATE PROCEDURE public."DelReader"(IN "PID" bigint)
    LANGUAGE plpgsql
    AS $$BEGIN
    DELETE FROM reader WHERE ID = "PID"; 
	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Такого читателя не существует!';
END$$;
 4   DROP PROCEDURE public."DelReader"(IN "PID" bigint);
       public          postgres    false            �            1255    16558    DelReaderBook(bigint) 	   PROCEDURE     �   CREATE PROCEDURE public."DelReaderBook"(IN "PID" bigint)
    LANGUAGE plpgsql
    AS $$BEGIN
    DELETE FROM reader_book WHERE ID = "PID"; 
	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Такой записи не существует!';
END$$;
 8   DROP PROCEDURE public."DelReaderBook"(IN "PID" bigint);
       public          postgres    false            �            1255    16571 6   InsBook(integer, text, text, integer, integer, bigint) 	   PROCEDURE     �  CREATE PROCEDURE public."InsBook"(IN "Pbook_registration_number" integer, IN "Ptitle" text, IN "Pauthor" text, IN "Pnumber_of_pages" integer, IN "Pthe_year_of_publishing" integer, IN "Pcategory_id" bigint)
    LANGUAGE plpgsql
    AS $$DECLARE k bigint;
BEGIN
	SELECT COUNT(*) INTO k from book
	WHERE book_registration_number="Pbook_registration_number"; 
	IF (k=0) THEN 
		INSERT INTO book (book_registration_number, title, author, number_of_pages, the_year_of_publishing, category_id)
		VALUES("Pbook_registration_number", "Ptitle", "Pauthor", "Pnumber_of_pages", "Pthe_year_of_publishing", "Pcategory_id");
	ELSE  
		RAISE NOTICE 'Такая книга уже есть!'; 
	END IF;	
END$$;
 �   DROP PROCEDURE public."InsBook"(IN "Pbook_registration_number" integer, IN "Ptitle" text, IN "Pauthor" text, IN "Pnumber_of_pages" integer, IN "Pthe_year_of_publishing" integer, IN "Pcategory_id" bigint);
       public          postgres    false            �            1255    16573    InsCategory(bigint, text) 	   PROCEDURE     v  CREATE PROCEDURE public."InsCategory"(IN "Pcode" bigint, IN "Ptitle" text)
    LANGUAGE plpgsql
    AS $$DECLARE k bigint;
BEGIN
	SELECT COUNT(*) INTO k from category
	WHERE code="Pcode" OR title="Ptitle"; 
	IF (k=0) THEN 
		INSERT INTO category (code, title)
		VALUES("Pcode", "Ptitle");
	ELSE  
		RAISE NOTICE 'Такой раздел уже есть!'; 
	END IF;	
END$$;
 J   DROP PROCEDURE public."InsCategory"(IN "Pcode" bigint, IN "Ptitle" text);
       public          postgres    false            �            1255    16572 0   InsReader(integer, text, text, text, text, text) 	   PROCEDURE     �  CREATE PROCEDURE public."InsReader"(IN "Plibrary_card_number" integer, IN "Plast_name" text, IN "Pfirst_name" text, IN "Pmiddle_name" text, IN "Padress" text, IN "Ppassport_data" text)
    LANGUAGE plpgsql
    AS $$DECLARE k bigint;
BEGIN
	SELECT COUNT(*) INTO k from reader
	WHERE library_card_number="Plibrary_card_number" OR passport_data="Ppassport_data"; 
	IF (k=0) THEN 
		INSERT INTO reader (library_card_number, last_name, first_name, middle_name, adress, passport_data)
		VALUES("Plibrary_card_number", "Plast_name", "Pfirst_name", "Pmiddle_name", "Padress", "Ppassport_data");
	ELSE  
		RAISE NOTICE 'Читатель с таким паспортом или номер читательского билета уже есть!'; 
	END IF;	
END$$;
 �   DROP PROCEDURE public."InsReader"(IN "Plibrary_card_number" integer, IN "Plast_name" text, IN "Pfirst_name" text, IN "Pmiddle_name" text, IN "Padress" text, IN "Ppassport_data" text);
       public          postgres    false            �            1255    16574 )   InsReaderBook(bigint, bigint, date, date) 	   PROCEDURE       CREATE PROCEDURE public."InsReaderBook"(IN "Preader_id" bigint, IN "Pbook_id" bigint, IN "Ptake_date" date, IN "Preturn_date" date)
    LANGUAGE plpgsql
    AS $$DECLARE k bigint;
BEGIN
	SELECT COUNT(*) INTO k from reader_book
	WHERE reader_id="Preader_id" AND book_id="Pbook_id";
	IF (k=0) THEN 
		INSERT INTO reader_book (reader_id, book_id, take_date, return_date)
		VALUES("Preader_id", "Pbook_id", "Ptake_date", "Preturn_date");
	ELSE  
		RAISE NOTICE 'Такая запись уже есть!'; 
	END IF;	
END$$;
 �   DROP PROCEDURE public."InsReaderBook"(IN "Preader_id" bigint, IN "Pbook_id" bigint, IN "Ptake_date" date, IN "Preturn_date" date);
       public          postgres    false            �            1255    16575 6   UpdBook(integer, text, text, integer, integer, bigint) 	   PROCEDURE     �  CREATE PROCEDURE public."UpdBook"(IN "Pbook_registration_number" integer, IN "Ptitle" text, IN "Pauthor" text, IN "Pnumber_of_pages" integer, IN "Pthe_year_of_publishing" integer, IN "Pcategory_id" bigint)
    LANGUAGE plpgsql
    AS $$DECLARE k bigint;
BEGIN
	SELECT COUNT(*) INTO k from book
	WHERE book_registration_number="Pbook_registration_number"; 
	IF (k=1) THEN 
		UPDATE book SET book_registration_number="Pbook_registration_number", title="Ptitle", author="Pauthor", number_of_pages="Pnumber_of_pages", the_year_of_publishing="Pthe_year_of_publishing", category_id="Pcategory_id"
		WHERE book_registration_number="Pbook_registration_number"; 
	ELSE  
		RAISE NOTICE 'Запись о такой книге отсутствует!'; 
	END IF;	
END$$;
 �   DROP PROCEDURE public."UpdBook"(IN "Pbook_registration_number" integer, IN "Ptitle" text, IN "Pauthor" text, IN "Pnumber_of_pages" integer, IN "Pthe_year_of_publishing" integer, IN "Pcategory_id" bigint);
       public          postgres    false            �            1255    16576    UpdCategory(bigint, text) 	   PROCEDURE     �  CREATE PROCEDURE public."UpdCategory"(IN "Pcode" bigint, IN "Ptitle" text)
    LANGUAGE plpgsql
    AS $$DECLARE k bigint;
BEGIN
	SELECT COUNT(*) INTO k from category
	WHERE code="Pcode"; 
	IF (k=1) THEN 
		UPDATE category SET code="Pcode", title="Ptitle"
		WHERE code="Pcode"; 
	ELSE  
		RAISE NOTICE 'Запись о таком разделе отсутствует!'; 
	END IF;	
END$$;
 J   DROP PROCEDURE public."UpdCategory"(IN "Pcode" bigint, IN "Ptitle" text);
       public          postgres    false            �            1255    16577 0   UpdReader(integer, text, text, text, text, text) 	   PROCEDURE     �  CREATE PROCEDURE public."UpdReader"(IN "Plibrary_card_number" integer, IN "Plast_name" text, IN "Pfirst_name" text, IN "Pmiddle_name" text, IN "Padress" text, IN "Ppassport_data" text)
    LANGUAGE plpgsql
    AS $$DECLARE k bigint;
BEGIN
	SELECT COUNT(*) INTO k from reader
	WHERE library_card_number="Plibrary_card_number"; 
	IF (k=1) THEN 
		UPDATE reader SET library_card_number="Plibrary_card_number", last_name="Plast_name", first_name="Pfirst_name", middle_name="Pmiddle_name", adress="Padress", passport_data="Ppassport_data"
		WHERE library_card_number="Plibrary_card_number"; 
	ELSE  
		RAISE NOTICE 'Запись о таком читателе отсутствует!'; 
	END IF;	
END$$;
 �   DROP PROCEDURE public."UpdReader"(IN "Plibrary_card_number" integer, IN "Plast_name" text, IN "Pfirst_name" text, IN "Pmiddle_name" text, IN "Padress" text, IN "Ppassport_data" text);
       public          postgres    false            �            1255    16597 )   UpdReaderBook(bigint, bigint, date, date) 	   PROCEDURE     6  CREATE PROCEDURE public."UpdReaderBook"(IN "Preader_id" bigint, IN "Pbook_id" bigint, IN "Ptake_date" date, IN "Preturn_date" date)
    LANGUAGE plpgsql
    AS $$DECLARE k bigint;
BEGIN
	SELECT COUNT(*) INTO k from reader_book
	WHERE reader_id="Preader_id" AND book_id="Pbook_id"; 
	IF (k=1) THEN 
		UPDATE reader_book SET reader_id="Preader_id", book_id="Pbook_id", take_date="Ptake_date", return_date="Preturn_date"
		WHERE reader_id="Preader_id" AND book_id="Pbook_id"; 
	ELSE  
		RAISE NOTICE 'Такая запись отсутствует!'; 
	END IF;	
END$$;
 �   DROP PROCEDURE public."UpdReaderBook"(IN "Preader_id" bigint, IN "Pbook_id" bigint, IN "Ptake_date" date, IN "Preturn_date" date);
       public          postgres    false            �            1255    16617    request(integer, bigint) 	   PROCEDURE     �  CREATE PROCEDURE public.request(IN "Plibrary_card_number" integer, IN "Pcategory_code" bigint)
    LANGUAGE plpgsql
    AS $$BEGIN
	PERFORM r.library_card_number, b.book_registration_number, b.title, b.author, s.code, rb.take_date
	FROM book b
    JOIN reader_book rb ON b.id = rb.book_id
    JOIN reader r ON rb.reader_id = r.id
    JOIN category s ON b.category_id = s.id
	WHERE r.library_card_number = "Plibrary_card_number" AND s.code = "Pcategory_code" AND rb.return_date IS NULL;
END$$;
 ^   DROP PROCEDURE public.request(IN "Plibrary_card_number" integer, IN "Pcategory_code" bigint);
       public          postgres    false            �            1259    16398    book    TABLE       CREATE TABLE public.book (
    id bigint NOT NULL,
    book_registration_number integer NOT NULL,
    title text NOT NULL,
    author text NOT NULL,
    number_of_pages integer NOT NULL,
    the_year_of_publishing integer NOT NULL,
    category_id bigint NOT NULL
);
    DROP TABLE public.book;
       public         heap    postgres    false            �            1259    16454 
   VwBigBooks    VIEW     f   CREATE VIEW public."VwBigBooks" AS
 SELECT title
   FROM public.book
  WHERE (number_of_pages > 500);
    DROP VIEW public."VwBigBooks";
       public          postgres    false    215    215            �            1259    16401    reader    TABLE     �   CREATE TABLE public.reader (
    id bigint NOT NULL,
    library_card_number integer NOT NULL,
    last_name text NOT NULL,
    first_name text NOT NULL,
    middle_name text,
    adress text NOT NULL,
    passport_data text NOT NULL
);
    DROP TABLE public.reader;
       public         heap    postgres    false            �            1259    16539    reader_book    TABLE     �   CREATE TABLE public.reader_book (
    id bigint NOT NULL,
    reader_id bigint NOT NULL,
    book_id bigint NOT NULL,
    take_date date NOT NULL,
    return_date date
);
    DROP TABLE public.reader_book;
       public         heap    postgres    false            �            1259    16554    VwCountReaderBooks    VIEW     �   CREATE VIEW public."VwCountReaderBooks" AS
 SELECT s.id,
    s.last_name,
    count(b.reader_id) AS num_books
   FROM (public.reader s
     LEFT JOIN public.reader_book b ON ((s.id = b.reader_id)))
  GROUP BY s.id, s.last_name;
 '   DROP VIEW public."VwCountReaderBooks";
       public          postgres    false    216    216    224            �            1259    16466    VwScienceFictionBooks2022    VIEW     �   CREATE VIEW public."VwScienceFictionBooks2022" AS
 SELECT title,
    author
   FROM public.book
  WHERE ((category_id = 1) AND (the_year_of_publishing = 2022));
 .   DROP VIEW public."VwScienceFictionBooks2022";
       public          postgres    false    215    215    215    215            �            1259    16432    book_id_seq    SEQUENCE     �   ALTER TABLE public.book ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    16407    category    TABLE     l   CREATE TABLE public.category (
    id bigint NOT NULL,
    code bigint NOT NULL,
    title text NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    16538    reader_book_id_seq    SEQUENCE     �   ALTER TABLE public.reader_book ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.reader_book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    224            �            1259    16493    reader_id_seq    SEQUENCE     �   ALTER TABLE public.reader ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reader_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            �            1259    16434    section_data_id_seq    SEQUENCE     �   ALTER TABLE public.category ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.section_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �          0    16398    book 
   TABLE DATA           �   COPY public.book (id, book_registration_number, title, author, number_of_pages, the_year_of_publishing, category_id) FROM stdin;
    public          postgres    false    215   �U       �          0    16407    category 
   TABLE DATA           3   COPY public.category (id, code, title) FROM stdin;
    public          postgres    false    217   �W       �          0    16401    reader 
   TABLE DATA           t   COPY public.reader (id, library_card_number, last_name, first_name, middle_name, adress, passport_data) FROM stdin;
    public          postgres    false    216   YX       �          0    16539    reader_book 
   TABLE DATA           U   COPY public.reader_book (id, reader_id, book_id, take_date, return_date) FROM stdin;
    public          postgres    false    224   {Y       �           0    0    book_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.book_id_seq', 12, true);
          public          postgres    false    218            �           0    0    reader_book_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.reader_book_id_seq', 6, true);
          public          postgres    false    223            �           0    0    reader_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.reader_id_seq', 5, true);
          public          postgres    false    222                        0    0    section_data_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.section_data_id_seq', 10, true);
          public          postgres    false    219            G           2606    16417    book book_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.book DROP CONSTRAINT book_pkey;
       public            postgres    false    215            C           2606    16610    reader card_check    CHECK CONSTRAINT     g   ALTER TABLE public.reader
    ADD CONSTRAINT card_check CHECK ((library_card_number > 100)) NOT VALID;
 6   ALTER TABLE public.reader DROP CONSTRAINT card_check;
       public          postgres    false    216    216            K           2606    16607    reader card_unique 
   CONSTRAINT     \   ALTER TABLE ONLY public.reader
    ADD CONSTRAINT card_unique UNIQUE (library_card_number);
 <   ALTER TABLE ONLY public.reader DROP CONSTRAINT card_unique;
       public            postgres    false    216            S           2606    16427    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    217            U           2606    16479    category code 
   CONSTRAINT     H   ALTER TABLE ONLY public.category
    ADD CONSTRAINT code UNIQUE (code);
 7   ALTER TABLE ONLY public.category DROP CONSTRAINT code;
       public            postgres    false    217            D           2606    16613    category code_check    CHECK CONSTRAINT     X   ALTER TABLE public.category
    ADD CONSTRAINT code_check CHECK ((code > 0)) NOT VALID;
 8   ALTER TABLE public.category DROP CONSTRAINT code_check;
       public          postgres    false    217    217            W           2606    16612    category code_unique 
   CONSTRAINT     O   ALTER TABLE ONLY public.category
    ADD CONSTRAINT code_unique UNIQUE (code);
 >   ALTER TABLE ONLY public.category DROP CONSTRAINT code_unique;
       public            postgres    false    217            E           2606    16614    reader_book date_check    CHECK CONSTRAINT     �   ALTER TABLE public.reader_book
    ADD CONSTRAINT date_check CHECK (((take_date < return_date) OR (return_date = NULL::date))) NOT VALID;
 ;   ALTER TABLE public.reader_book DROP CONSTRAINT date_check;
       public          postgres    false    224    224    224    224            M           2606    16477 !   reader library_card_number_unique 
   CONSTRAINT     k   ALTER TABLE ONLY public.reader
    ADD CONSTRAINT library_card_number_unique UNIQUE (library_card_number);
 K   ALTER TABLE ONLY public.reader DROP CONSTRAINT library_card_number_unique;
       public            postgres    false    216            B           2606    16605    book pages_check    CHECK CONSTRAINT     `   ALTER TABLE public.book
    ADD CONSTRAINT pages_check CHECK ((number_of_pages > 0)) NOT VALID;
 5   ALTER TABLE public.book DROP CONSTRAINT pages_check;
       public          postgres    false    215    215            O           2606    16609    reader passport_unique 
   CONSTRAINT     Z   ALTER TABLE ONLY public.reader
    ADD CONSTRAINT passport_unique UNIQUE (passport_data);
 @   ALTER TABLE ONLY public.reader DROP CONSTRAINT passport_unique;
       public            postgres    false    216            Y           2606    16543    reader_book reader_book_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.reader_book
    ADD CONSTRAINT reader_book_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.reader_book DROP CONSTRAINT reader_book_pkey;
       public            postgres    false    224            Q           2606    16431    reader reader_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.reader
    ADD CONSTRAINT reader_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.reader DROP CONSTRAINT reader_pkey;
       public            postgres    false    216            I           2606    16475    book registration 
   CONSTRAINT     `   ALTER TABLE ONLY public.book
    ADD CONSTRAINT registration UNIQUE (book_registration_number);
 ;   ALTER TABLE ONLY public.book DROP CONSTRAINT registration;
       public            postgres    false    215            [           2606    16549    reader_book book_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY public.reader_book
    ADD CONSTRAINT book_fkey FOREIGN KEY (book_id) REFERENCES public.book(id);
 ?   ALTER TABLE ONLY public.reader_book DROP CONSTRAINT book_fkey;
       public          postgres    false    4679    215    224            Z           2606    16435    book fk_category    FK CONSTRAINT     �   ALTER TABLE ONLY public.book
    ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES public.category(id) NOT VALID;
 :   ALTER TABLE ONLY public.book DROP CONSTRAINT fk_category;
       public          postgres    false    4691    215    217            \           2606    16544    reader_book reader_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.reader_book
    ADD CONSTRAINT reader_fkey FOREIGN KEY (reader_id) REFERENCES public.reader(id);
 A   ALTER TABLE ONLY public.reader_book DROP CONSTRAINT reader_fkey;
       public          postgres    false    224    216    4689            �   �  x�MR[r�@��=Ş�Ү^�]8����C��*�>�*E�@�%s��ѳU�pY��tOw�PD���,�ON��I����-'�xܣǳnX�����"T\I�R�k~�`\�eҍv����k��z�Y.��i
�s�t�(*����=���?O̞s����3F�'=g�E�#��n���#Y�D�_�d;{�|4X�#uۘ�Vװ���Şݣv�}�D��oY0RC��Ľ�Q��
��Q��㛽Cr��ʸ�\���*�uDX��#�D��q���J,#)��JZ����\���L���x\'~{	aUe�g�oE��]#UP
O5ۦ�IK�y'�#<R�h&c�X7�.X8"���|�/ܧ���F��!����qCā��^h'Uh�
�����;O��k��-f�̖|
�c���L�Ȣt�6ܧ�|�ɜ���P��.y�+����R/�ے-!��l�(-0A��Kj�Z�G�;V�[1tf��ש���^�r��#c��      �   �   x�5N;
�P�g#n��.&����+Q[!�ѐ��
�n�f�fa��%xg�!lX��nˎ�DP�li�9��42}ػ�ᇭ��x���#	4O�5��m8H
M�'C*ɠ��a�m�y'K{�6�f�uv�ۂR
h����;��Z�g/���y�q�      �     x�M�]N�0��ק� 9��s��E�'*@���sh)��\a�F캨�����yƎJg	�|�~��[,	w"Z4\����E�3�rڌ���2$Oe��M��29�:,�k��WY�R�V�:=�!�Xa˗zQH�,Pt��x��'|H�a�둧��`}$ٞщ�c�I�G�p>D���?��k�W�\�ią��X����s�S|I���f�IQQ��X�����=r��KPI��D���!�[�>�Y-$4��	��O�2�Ƙ?���      �   R   x�M���0C�x�T|٢d�9�(�f�g�����Zco�7J@��t�8l9�C"狞�&L9�Z�������� � bY�     