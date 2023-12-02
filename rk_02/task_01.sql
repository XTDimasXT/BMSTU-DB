CREATE TABLE IF NOT EXISTS Region (
    id serial primary key,
    name_reg text not null,
    description_reg text not null
);

CREATE TABLE IF NOT EXISTS Sanatorium (
    id serial primary key,
    name_san text not null,
    year_found int not null,
    description_san text not null,
    region_id int references Region(id)
);

CREATE TABLE IF NOT EXISTS Vacationer (
    id serial primary key,
    fio text not null,
    year_birth int not null,
    adress text not null,
    email text not null
);

CREATE TABLE IF NOT EXISTS Sanatorium_Vacationer (
    id serial primary key,
    sanatorium_id int references Sanatorium(id),
    vacationer_id int references Vacationer(id)
);



ALTER TABLE Sanatorium_Vacationer
    ADD CONSTRAINT fk_sanatorium FOREIGN KEY (sanatorium_id) REFERENCES Sanatorium(id) ON DELETE CASCADE;

ALTER TABLE Sanatorium_Vacationer
    ADD CONSTRAINT fk_vacationer FOREIGN KEY (vacationer_id) REFERENCES Vacationer(id) ON DELETE CASCADE;



insert into Region (name_reg, description_reg) values ('Boras', 'Mycobilimbia lobulata (Sommerf.) Hafellner');
insert into Region (name_reg, description_reg) values ('Florence', 'Porophyllum pygmaeum Keil & J. Morefield');
insert into Region (name_reg, description_reg) values ('Phon Phisai', 'Lithophragma (Nutt.) Torr. & A. Gray');
insert into Region (name_reg, description_reg) values ('Nanling', 'Cuscuta odontolepis Engelm.');
insert into Region (name_reg, description_reg) values ('Tanzybey', 'Manilkara bidentata (A. DC.) A. Chev ssp. surinamensis (Miq.) T.D. Penn.');
insert into Region (name_reg, description_reg) values ('Hazlov', 'Anthracothecium staurosporum (Tuck. ex Willey) Zahlbr.');
insert into Region (name_reg, description_reg) values ('Las Vegas', 'Corethrogyne filaginifolia (Hook. & Arn.) Nutt. var. californica (DC.) J.P. Saroyan');
insert into Region (name_reg, description_reg) values ('Spartanburg', 'Calliscirpus criniger (A. Gray) C.N. Gilmour, J.R. Starr & Naczi');
insert into Region (name_reg, description_reg) values ('Margacina', 'Chaenothecopsis debilis (Turner & Borrer ex Sm.) Tibell');
insert into Region (name_reg, description_reg) values ('Chaparral', 'Sisyrinchium mucronatum Michx.');


insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Alencon', 2010, 'Trichosurus vulpecula', 1);
insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Zmijavci', 2013, 'Tadorna tadorna', 1);
insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Nanxing', 2008, 'Cracticus nigroagularis', 3);
insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Paprotnia', 1994, 'Theropithecus gelada', 4);
insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Mizan Teferi', 1996, 'Cacatua galerita', 4);
insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Guacari', 2010, 'Eolophus roseicapillus', 5);
insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Youdunjie', 1992, 'unavailable', 7);
insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Shenavan', 2008, 'Cereopsis novaehollandiae', 8);
insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Livadion', 2006, 'Equus burchelli', 9);
insert into Sanatorium (name_san, year_found, description_san, region_id) values ('Rafael Perazza', 1999, 'Coluber constrictor', 10);


insert into Vacationer (fio, year_birth, adress, email) values ('Myrna Corradi', 1995, '8 Eagle Crest Parkway', 'mcorradi0@networkadvertising.org');
insert into Vacationer (fio, year_birth, adress, email) values ('Krystyna Picardo', 1995, '1488 Hovde Plaza', 'kpicardo1@sun.com');
insert into Vacationer (fio, year_birth, adress, email) values ('Nikolia Ciciotti', 1992, '0 Helena Junction', 'nciciotti2@weibo.com');
insert into Vacationer (fio, year_birth, adress, email) values ('Tate Lackington', 1992, '77 Muir Plaza', 'tlackington3@cbsnews.com');
insert into Vacationer (fio, year_birth, adress, email) values ('Lowell Crisford', 2004, '36551 Macpherson Hill', 'lcrisford4@va.gov');
insert into Vacationer (fio, year_birth, adress, email) values ('Eyde Eddoes', 1993, '74559 Banding Avenue', 'eeddoes5@imgur.com');
insert into Vacationer (fio, year_birth, adress, email) values ('Gregoor Mordey', 1989, '48 Vermont Plaza', 'gmordey6@spiegel.de');
insert into Vacationer (fio, year_birth, adress, email) values ('Lemmy McIlroy', 2004, '48 Orin Park', 'lmcilroy7@salon.com');
insert into Vacationer (fio, year_birth, adress, email) values ('Aluino Harriss', 2006, '96447 Kropf Plaza', 'aharriss8@amazon.co.uk');
insert into Vacationer (fio, year_birth, adress, email) values ('Sibylle Ruddy', 2001, '9216 Sage Trail', 'sruddy9@berkeley.edu');


insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (1, 1);
insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (1, 2);
insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (1, 3);
insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (3, 2);
insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (3, 4);
insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (6, 5);
insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (6, 6);
insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (8, 8);
insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (9, 9);
insert into Sanatorium_Vacationer (sanatorium_id, vacationer_id) values (10, 10);
