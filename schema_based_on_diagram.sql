CREATE DATABASE clinic;

-- Create the patients table
CREATE TABLE patients (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE
);

-- Create the medical_histories table
CREATE TABLE medical_histories (
    id INT PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(Id)
);

-- Create the treatments table
CREATE TABLE treatments (
    id INT PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255)
);

-- Create the invoices table
CREATE TABLE invoices (
    id INT PRIMARY KEY,
    total_amount DECIMAL(10,2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(Id)
);

-- Create the invoice_items table
CREATE TABLE invoice_items (
    id INT PRIMARY KEY,
    unit_price DECIMAL(10,2),
    quantity INT,
    total_price DECIMAL(10,2),
    invoice_id INT,
    treatment_id INT,
    FOREIGN KEY (invoice_id) REFERENCES invoices(Id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(Id)
);

-- Create join tables many-to-many relationship
CREATE TABLE medical_histories_treatments (
    medical_histories_id INT NOT NULL,
    treatments_id INT NOT NULL,
    CONSTRAINT fk_medical_histories
    FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id),
    CONSTRAINT fk_treatments
    FOREIGN KEY(treatments_id) REFERENCES treatments(id)
);

-- Create a foreign key index
CREATE INDEX patients_ind ON medical_histories(patient_id);
CREATE INDEX medical_history_ind ON invoices(medical_history_id);
CREATE INDEX invoices_ind ON invoice_items(invoice_id);
CREATE INDEX treatment_ind ON invoice_items(treatment_id);
CREATE INDEX medical_histories_ind ON medical_histories_treatments(medical_histories_id);
CREATE INDEX treatments_ind ON medical_histories_treatments(treatments_id);
