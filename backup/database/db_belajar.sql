PGDMP  %    9                 |            belajar    16.1    16.1     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16610    belajar    DATABASE     �   CREATE DATABASE belajar WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE belajar;
                postgres    false            M           1247    16644    product_category    TYPE     _   CREATE TYPE public.product_category AS ENUM (
    'Makanan',
    'Minuman',
    'Lain-Lain'
);
 #   DROP TYPE public.product_category;
       public          postgres    false            �            1259    16619    barang    TABLE     �   CREATE TABLE public.barang (
    kode integer NOT NULL,
    name character varying(255) NOT NULL,
    harga integer DEFAULT 0 NOT NULL,
    jumlah integer DEFAULT 0 NOT NULL,
    waktu timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.barang;
       public         heap    postgres    false            �            1259    16634    products    TABLE     B  CREATE TABLE public.products (
    id character varying(10) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    price integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    category public.product_category
);
    DROP TABLE public.products;
       public         heap    postgres    false    845            �            1259    16651    t_order    TABLE     f   CREATE TABLE public.t_order (
    id bigint,
    barang_id character varying,
    quantity integer
);
    DROP TABLE public.t_order;
       public         heap    postgres    false            �          0    16619    barang 
   TABLE DATA           B   COPY public.barang (kode, name, harga, jumlah, waktu) FROM stdin;
    public          postgres    false    215   �       �          0    16634    products 
   TABLE DATA           `   COPY public.products (id, name, description, price, quantity, created_at, category) FROM stdin;
    public          postgres    false    216   �       �          0    16651    t_order 
   TABLE DATA           :   COPY public.t_order (id, barang_id, quantity) FROM stdin;
    public          postgres    false    217   �       *           2606    16642    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    216            �      x������ � �      �   �   x��нn�0��y�{��c;��P�]*�\ED,��b2����a��B��ɺ��o7��Ďα�/�.,�������k���2<*�P���Fe �²�6������($Of������h`�4�"�\'��_��4ӶPkUr����6'�O��(e�zeifnt��	�qpPt����g�|1��>��������6L���6�u�V�?��/F>��J�z<����7ɥ^�?�I�� 1��=      �   %   x�3�0000�4�2��8͡,C#cNC�=... y*�     