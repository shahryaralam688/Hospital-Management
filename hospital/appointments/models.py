from django.db import models
from patients.models import Patients
from doctors.models import Doctors
from typing import List, Tuple, Any

class Appointment(models.Model):
    
    appointment_id: str = models.CharField(max_length=5)
    patient_id: models.ForeignKey = models.ForeignKey(Patients, on_delete=models.CASCADE)
    token_number: str = models.CharField(max_length=10)
    doctor_name: models.ForeignKey = models.ForeignKey(Doctors, on_delete=models.CASCADE)
    problem: str = models.CharField(max_length=20)
    STATUS: List[Tuple[str, str]] = [
        ('pending','Aending'),
        ('active','Active')
    ]
    status: str = models.CharField(max_length=20, choices=STATUS, default='Pending')
    
    def __str__(self) -> str:
        return str(self.appointment_id)
    
# Create your models here.
