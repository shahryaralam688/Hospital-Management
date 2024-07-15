from django.db import models
from patients.models import Patients
from doctors.models import Doctors

class Appointment(models.Model):
    
    appointment_id =models.CharField(max_length=5)
    patient_id = models.ForeignKey(Patients, on_delete=models.CASCADE)
    token_number =models.CharField(max_length=10)
    doctor_name = models.ForeignKey(Doctors, on_delete=models.CASCADE)
    problem = models.CharField(max_length=20)
    STATUS =[
        ('pending','Aending'),
        ('active','Active')
    ]
    status = models.CharField(max_length=20, choices=STATUS, default='Pending')
    
    def __str__(self):
        return str(self.appointment_id)
    
# Create your models here.