from django.db import models
from patients.models import Patients
from doctors.models import Doctors

class Appointment(models.Model):
    
	appointment_id =models.CharField(max_length=20)
    patient_id = models.ForeignKey(Patients, on_delete=models.CASCADE)
    token_number =models.CharField(max_length=10)
    doctor_name = models.ForeignKey(Doctors, on_delete=models.CASCADE)
    problem = models.CharField(max_length=20)
# Create your models here.