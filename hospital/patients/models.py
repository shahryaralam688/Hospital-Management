from django.db import models
from django.core.validators import RegexValidator
from django.utils import timezone
from doctors.models import Doctors
from typing import Optional, List, Tuple, Any


class Patients(models.Model):
    STATUS_CHOICES: List[Tuple[str, str]] = [
        ('Pending', 'Pending'),
        ('Complete', 'Complete'),
        ('Cancelled', 'Cancelled'),
    ]
    Gender: List[Tuple[str, str]] = [
        ('Male','Male'),
        ('female','female'),
        ('Other','Other'),        
    ]
    
    patient_name: str = models.CharField(max_length=50)
    date_of_birth: str = models.CharField(max_length=12,default="Date Of Birth")
    age: Optional[int] = models.IntegerField(null=True, blank=True, default="Age")
    patient_doctor_name: str = models.CharField(Doctors,max_length=100,default="Doctor Name")  
    phone: str = models.CharField(max_length=20, validators=[RegexValidator(r'^\+?[0-9\-]+$')])
    email: str = models.EmailField(default="abc@gmail.com")
    gender: str = models.CharField(max_length=10, choices=Gender, default="Gender")
    status: str = models.CharField(max_length=10, choices=STATUS_CHOICES, default='Status')
    last_visit: models.DateTimeField = models.DateTimeField(default=timezone.now)
    address: str = models.CharField(max_length=200, default="Address")
    
    def __str__(self) -> str:
        return str(self.patient_name)
# Create your models here.
