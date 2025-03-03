create database hospital;
use hospital;
#doctor table;
create table doctor (
doctor_id int primary key not null, 
doctor_name varchar(50) not null, 
doctor_phone varchar(11) not null, 
specialization varchar(50) not null
);

#medical record table
create table medical_record (
record_id int primary key not null,
disease varchar(50) not null,
treatment varchar(250) not null,
record_date date not null
);

#room table
create table room(
room_num int primary key not null,
room_type varchar(50),
room_price int
);

#patient table
#patient - doctor : (one to many)
#patient - medical : (one to one)
#patient - room : (one to one)
create table patient (
patient_id int primary key not null,
patient_name varchar(50) not null,
patient_gender ENUM ('Female', 'Male') not null,
patient_phone varchar(11) not null,
patient_address varchar(110) not null,
doctor_id int not null,
constraint fk_doctor_patient foreign key (doctor_id) references doctor (doctor_id),
record_id int,
constraint fk_record_patient foreign key (record_id) references medical_record (record_id),
room_num int,
constraint fk_room_patient foreign key (room_num) references room (room_num)
);

#billing table
#patient - billing : (one to many)
create table billing (
bill_id int primary key not null,
treatment_bill decimal(10,2) not null,
room_bill decimal(10,2) not null,
patient_id int not null,
total_billing decimal(10,2) as (treatment_bill+room_bill),
constraint fk_patient_billing foreign key (patient_id) references patient (patient_id)
);
#medical attendant
#pateint - medical attendant : (many to many)
create table medical_attendant(
attendant_id int primary key not null,
attendant_name varchar(50) not null,
attendant_type enum('nurse','murses','ward boy', 'ward girl')
);

#many to many table
create table patient_attendant (
attendant_id int not null,
patient_id int not null,
primary key (attendant_id, patient_id),
constraint fk_patient_attendant1 foreign key (patient_id) references patient (patient_id),
constraint fk_patient_attendant2 foreign key (attendant_id) references medical_attendant (attendant_id)
);
INSERT INTO doctor (doctor_id, doctor_name, doctor_phone, specialization) VALUES
(4, 'Dr. Miller', '5556667788', 'Dermatology'),(5, 'Dr. White', '9998887766', 'Neurology');
INSERT INTO medical_record (record_id, disease, treatment, record_date) VALUES
(4, 'Diabetes', 'Insulin therapy and dietary changes', '2023-04-05'),(5, 'Concussion', 'Rest and observation', '2023-05-12');
INSERT INTO room (room_num, room_type, room_price) VALUES
(104, 'Standard', 100),(105, 'Deluxe', 150);

INSERT INTO patient (patient_id, patient_name, patient_gender, patient_phone, patient_address, doctor_id, record_id, room_num) VALUES
(4, 'Alice Johnson', 'Female', '5554445566', '789 Oak St', 4, 4, 104),(5, 'Charlie Brown', 'Male', '5553335566', '987 Pine St', 5, 5, 105);

INSERT INTO billing (bill_id, treatment_bill, room_bill, patient_id) VALUES
(4, 90.25, 100.00, 4),(5, 60.50, 150.00, 5);

INSERT INTO medical_attendant (attendant_id, attendant_name, attendant_type) VALUES
(4, 'Nurse Smith', 'nurse'),(5, 'Mr. White', 'ward boy');

INSERT INTO patient_attendant (attendant_id, patient_id) VALUES
(4, 4),(5, 5);
INSERT INTO doctor (doctor_id, doctor_name, doctor_phone, specialization) VALUES
(1, 'Dr. Smith', '12345678901', 'Cardiology'),(2, 'Dr. Johnson', '98765432101', 'Orthopedics'),(3, 'Dr. Brown', '11223344556', 'Pediatrics');
INSERT INTO doctor (doctor_id, doctor_name, doctor_phone, specialization) VALUES
(6, 'Dr. Anderson', '5551234567', 'Ophthalmology'),(7, 'Dr. Garcia', '5552345678', 'Gynecology');

INSERT INTO medical_record (record_id, disease, treatment, record_date) VALUES
(1, 'Hypertension', 'Prescription medication and lifestyle changes', '2023-01-15'),(2, 'Fractured Arm', 'Casting and pain management', '2023-02-20')
,(3, 'Common Cold', 'Rest and over-the-counter medication', '2023-03-10');

INSERT INTO room (room_num, room_type, room_price) VALUES
(101, 'Standard', 100),(102, 'Deluxe', 150),(103, 'Suite', 200);

INSERT INTO patient (patient_id, patient_name, patient_gender, patient_phone, patient_address, doctor_id, record_id, room_num) VALUES
(1, 'John Doe', 'Male', '5551112233', '123 Main St', 1, 1, 101),(2, 'Jane Smith', 'Female', '5552223344', '456 Oak St', 2, 2, 102),
(3, 'Bob Johnson', 'Male', '5553334455', '789 Pine St', 3, 3, 103);

INSERT INTO billing (bill_id, treatment_bill, room_bill, patient_id) VALUES
(1, 75.50, 100.00, 1),(2, 120.75, 150.00, 2),(3, 50.25, 200.00, 3);

INSERT INTO medical_attendant (attendant_id, attendant_name, attendant_type) VALUES
(1, 'Nurse Johnson', 'nurse'),
(2, 'Mr. Smith', 'ward boy'),
(3, 'Ms. Brown', 'murses');

INSERT INTO patient_attendant (attendant_id, patient_id) VALUES
(1, 1),(2, 2),(3, 3);
INSERT INTO patient (patient_id, patient_name, patient_gender, patient_phone, patient_address, doctor_id, record_id, room_num) VALUES
(6, 'Eva Wilson', 'Female', '5557778899', '456 Maple St', 1, 1, 101),
(7, 'Sam Roberts', 'Male', '5558889900', '789 Elm St', 2, 2, 102),
(8, 'Olivia Davis', 'Female', '5559990011', '123 Birch St', 3, 3, 103);

INSERT INTO billing (bill_id, treatment_bill, room_bill, patient_id) VALUES
(6, 80.00, 100.00, 6),(7, 110.75, 150.00, 7),(8, 75.25, 200.00, 8);

INSERT INTO patient_attendant (attendant_id, patient_id) VALUES
(1, 6),(2, 7),(3, 8),(4, 8),(5, 6);
-- selecting the patients informations
select * from patient;
-- select all doctors and their patients names  
select p.patient_name,d.doctor_name from patient p  right join doctor d on p.doctor_id=d.doctor_id;
-- selecting each patient and their diseases
select p.patient_name,mr.disease from patient p join medical_record mr on p.record_id=mr.record_id;
-- selecting patients name , id and their totall bill >200
select p.patient_name,p.patient_id,b.total_billing from patient p join billing b on p.patient_id=b.patient_id  where b.total_billing>200 ;
-- select the patients ,their dotor names and their room type
 select p.patient_name,d.doctor_name,r.room_type from patient p  join doctor d on p.doctor_id=d.doctor_id
 join room r on p.room_num=r.room_num;
-- Select the total number of patients for each doctor
SELECT d.doctor_name, COUNT(p.patient_id) AS total_patients
FROM doctor d
LEFT JOIN patient p ON p.doctor_id = d.doctor_id
GROUP BY d.doctor_name;