from django.db import models
from typing import Optional, Any


# create model for Doctors.
class Doctor(models.Model):
    doctor_Name: str = models.CharField(max_length=100)
    Date_of_birth: str = models.CharField(max_length=100)
    experience_level: int = models.IntegerField()
    age: int = models.IntegerField()
    specialization: str = models.CharField(max_length=50) 
    phone: int = models.IntegerField()
    email: str = models.EmailField(max_length=100)
    gender: str = models.CharField(max_length=50)
    address: str = models.TextField()
    status: str = models.CharField(max_length=50, default='Null')
    
    def __str__(self) -> str:
        return self.doctor_Name

# Create your models here.
class Patient(models.Model):
    patient_Name: str = models.CharField(max_length=100)
    Date_of_birth: Optional[models.DateTimeField] = models.DateTimeField(null=True, blank=True)
    age: int = models.IntegerField()
    phone: int = models.IntegerField()
    email: str = models.EmailField(max_length=100)
    gender: str = models.CharField(max_length=50)
    address: str = models.TextField()
    status: str = models.CharField(max_length=50, default='Null')
    last_view: Optional[models.DateTimeField] = models.DateTimeField(null=True, blank=True)
    
    def __str__(self) -> str:
        return self.patient_Name
