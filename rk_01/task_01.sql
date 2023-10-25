CREATE DATABASE RK1;

CREATE TABLE IF NOT EXISTS types_candies
(
    id SERIAL PRIMARY KEY,
    name_supplier VARCHAR(100),
    composition VARCHAR(100),
    description_candy VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS suppliers
(
    id SERIAL PRIMARY KEY,
    name_supplier VARCHAR(100),
    inn BIGINT,
    adress VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS outlets
(
    id SERIAL PRIMARY KEY,
    name_outlet VARCHAR(100),
    adress VARCHAR(100),
    date_registration DATE,
    rate DECIMAL(3, 2)
);

CREATE TABLE IF NOT EXISTS types_candies_suppliers
(
    id SERIAL PRIMARY KEY,
    types_candy_id INT REFERENCES candies (id),
    supplier_id INT REFERENCES suppliers (id)
);

CREATE TABLE IF NOT EXISTS suppliers_outlets
(
    id SERIAL PRIMARY KEY,
    supplier_id INT REFERENCES suppliers (id),
    outlet_id INT REFERENCES outlets (id)
);

CREATE TABLE IF NOT EXISTS types_candies_outlets
(
    id SERIAL PRIMARY KEY,
    types_candy_id INT REFERENCES types_candies (id),
    outlet_id INT REFERENCES outlets (id)
);

ALTER TABLE types_candies_suppliers
    ADD CONSTRAINT fk_types_candy FOREIGN KEY (types_candy_id) REFERENCES candies(id) ON DELETE CASCADE;
ALTER TABLE types_candies_suppliers
    ADD CONSTRAINT fk_supplier_id FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE;
ALTER TABLE suppliers_outlets
    ADD CONSTRAINT fk_supplier_id2 FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE;
ALTER TABLE suppliers_outlets
    ADD CONSTRAINT fk_outlet_id FOREIGN KEY (outlet_id) REFERENCES outlets(id) ON DELETE CASCADE;
ALTER TABLE types_candies_outlets
    ADD CONSTRAINT fk_types_candy2 FOREIGN KEY (types_candy_id) REFERENCES candies(id) ON DELETE CASCADE;
ALTER TABLE types_candies_outlets
    ADD CONSTRAINT fk_outlet_id2 FOREIGN KEY (supplier_id) REFERENCES outlets(id) ON DELETE CASCADE;
    

-- types_candies
insert into types_candies (name_supplier, composition, description_candy) values ('Konstance', 'Sierra November Echo Whiskey Victor Juliett Yankee X-ray Uniform Charlie Lima Golf', 'Spheniscus magellanicus');
insert into types_candies (name_supplier, composition, description_candy) values ('Benjie', 'Lima November Alfa Zulu Bravo Echo Juliett Quebec Delta Foxtrot X-ray Mike Whiskey Oscar', 'Ploceus rubiginosus');
insert into types_candies (name_supplier, composition, description_candy) values ('Neill', 'Whiskey Papa Quebec Mike Golf Echo November Tango Uniform India Lima Alfa Sierra X-ray Romeo', 'unavailable');
insert into types_candies (name_supplier, composition, description_candy) values ('Bride', 'Juliett Echo November Alfa Delta Romeo Uniform Victor Charlie Sierra Tango Oscar Yankee India', 'Odocoileus hemionus');
insert into types_candies (name_supplier, composition, description_candy) values ('Waldon', 'Victor Tango Uniform X-ray Whiskey Lima Alfa Oscar Bravo Mike', 'Sagittarius serpentarius');
insert into types_candies (name_supplier, composition, description_candy) values ('Gunter', 'Charlie Lima Victor Alfa Zulu Juliett Tango November Golf Foxtrot', 'Cercatetus concinnus');
insert into types_candies (name_supplier, composition, description_candy) values ('Evangelina', 'Delta X-ray Quebec Charlie Mike Papa Yankee Oscar November India Victor Hotel', 'Varanus salvator');
insert into types_candies (name_supplier, composition, description_candy) values ('Erl', 'November Yankee Kilo Romeo Foxtrot Alfa Oscar Bravo Juliett Zulu Lima', 'Nectarinia chalybea');
insert into types_candies (name_supplier, composition, description_candy) values ('Cathe', 'Papa Hotel Whiskey Charlie Romeo Golf Yankee Echo Mike Sierra November Bravo Oscar Foxtrot', 'Ursus americanus');
insert into types_candies (name_supplier, composition, description_candy) values ('Archambault', 'Bravo Romeo Delta X-ray Echo Kilo Foxtrot Papa Zulu Golf Whiskey Yankee Quebec Juliett', 'Semnopithecus entellus');

-- suppliers
insert into suppliers (name_supplier, inn, adress) values ('Robin', '35342756735', '7 Warbler Circle');
insert into suppliers (name_supplier, inn, adress) values ('Koral', '67068862851', '41319 Elka Parkway');
insert into suppliers (name_supplier, inn, adress) values ('Winn', '56022124608', '6737 Annamark Park');
insert into suppliers (name_supplier, inn, adress) values ('Pryce', '56022547662', '36794 Hudson Plaza');
insert into suppliers (name_supplier, inn, adress) values ('Jo ann', '67713647068', '97839 Prentice Crossing');
insert into suppliers (name_supplier, inn, adress) values ('Nessie', '56022356694', '15 High Crossing Alley');
insert into suppliers (name_supplier, inn, adress) values ('Glynis', '36046012556', '272 Acker Hill');
insert into suppliers (name_supplier, inn, adress) values ('Neal', '63858951577', '652 Bultman Plaza');
insert into suppliers (name_supplier, inn, adress) values ('Celesta', '3572145716579', '551 Chinook Drive');
insert into suppliers (name_supplier, inn, adress) values ('Heda', '50076648641', '39981 Schiller Plaza');

-- outlets
insert into outlets (name_outlet, adress, date_registration, rate) values ('Hugo', '57 Michigan Junction', '2020-02-04', 1.16);
insert into outlets (name_outlet, adress, date_registration, rate) values ('Darius', '57 Michigan Junction', '2017-08-19', 7.3);
insert into outlets (name_outlet, adress, date_registration, rate) values ('Elissa', '38705 Del Sol Pass', '2017-10-07', 7.6);
insert into outlets (name_outlet, adress, date_registration, rate) values ('Lalo', '00 Darwin Court', '2019-03-03', 5.18);
insert into outlets (name_outlet, adress, date_registration, rate) values ('Orion', '2308 Crescent Oaks Avenue', '2017-06-26', 4.51);
insert into outlets (name_outlet, adress, date_registration, rate) values ('Gina', '57 Michigan Junction', '2020-06-22', 8.58);
insert into outlets (name_outlet, adress, date_registration, rate) values ('Jacynth', '556 Raven Terrace', '2017-10-18', 6.21);
insert into outlets (name_outlet, adress, date_registration, rate) values ('Humfrid', '00 Darwin Court', '2018-05-28', 5.9);
insert into outlets (name_outlet, adress, date_registration, rate) values ('Sibeal', '97033 Green Ridge Place', '2020-03-02', 7.54);
insert into outlets (name_outlet, adress, date_registration, rate) values ('Annabal', '078 Glendale Court', '2017-02-28', 5.44);

-- 
insert into types_candies_suppliers(types_candy_id, supplier_id) values (1, 1);
insert into types_candies_suppliers(types_candy_id, supplier_id) values (1, 2);
insert into types_candies_suppliers(types_candy_id, supplier_id) values (2, 3);
insert into types_candies_suppliers(types_candy_id, supplier_id) values (3, 1);
insert into types_candies_suppliers(types_candy_id, supplier_id) values (4, 4);
insert into types_candies_suppliers(types_candy_id, supplier_id) values (5, 5);
insert into types_candies_suppliers(types_candy_id, supplier_id) values (6, 6);
insert into types_candies_suppliers(types_candy_id, supplier_id) values (7, 7);
insert into types_candies_suppliers(types_candy_id, supplier_id) values (8, 8);
insert into types_candies_suppliers(types_candy_id, supplier_id) values (9, 9);

--
insert into suppliers_outlets(supplier_id, outlet_id) values (1, 1);
insert into suppliers_outlets(supplier_id, outlet_id) values (1, 2);
insert into suppliers_outlets(supplier_id, outlet_id) values (2, 3);
insert into suppliers_outlets(supplier_id, outlet_id) values (3, 1);
insert into suppliers_outlets(supplier_id, outlet_id) values (4, 4);
insert into suppliers_outlets(supplier_id, outlet_id) values (5, 5);
insert into suppliers_outlets(supplier_id, outlet_id) values (6, 6);
insert into suppliers_outlets(supplier_id, outlet_id) values (7, 7);
insert into suppliers_outlets(supplier_id, outlet_id) values (8, 8);
insert into suppliers_outlets(supplier_id, outlet_id) values (9, 9);

--
insert into types_candies_outlets(types_candy_id, outlet_id) values (1, 1);
insert into types_candies_outlets(types_candy_id, outlet_id) values (1, 2);
insert into types_candies_outlets(types_candy_id, outlet_id) values (2, 3);
insert into types_candies_outlets(types_candy_id, outlet_id) values (3, 1);
insert into types_candies_outlets(types_candy_id, outlet_id) values (4, 4);
insert into types_candies_outlets(types_candy_id, outlet_id) values (5, 5);
insert into types_candies_outlets(types_candy_id, outlet_id) values (6, 6);
insert into types_candies_outlets(types_candy_id, outlet_id) values (7, 7);
insert into types_candies_outlets(types_candy_id, outlet_id) values (8, 8);
insert into types_candies_outlets(types_candy_id, outlet_id) values (9, 9);