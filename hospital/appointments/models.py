from django.db import models
from patients.models import Patients

class Appointment(models.Model):
    
	appointment_id =models.CharField(max_length=20)
    # patient_id = 
    # token_number =
    # doctor_name
    # problem
# Create your models here.
