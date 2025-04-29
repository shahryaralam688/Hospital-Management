from django.db import models
from django.core.validators import RegexValidator
from typing import Optional, List, Tuple, Any

class Doctors(models.Model):
    #Date Of Birth Age  Email Gender Doctor detail address
    Gender: List[Tuple[str, str]] = [
        ('Male','Male'),
        ('female','female'),
        ('Other','Other'),        
    ]
    Availability: List[Tuple[str, str]] = [
        ('Available','Available'),
        ('Not Available','Not Available'),
        ('Leave','Leave'),
    ]
    doctor_name: str = models.CharField(max_length=50)
    date_of_birth: str = models.CharField(max_length=12,default="Date Of Birth")
    age: Optional[int] = models.IntegerField(null=True, blank=True, default="Age")
    email: str = models.EmailField(default="abc@gmail.com")
    gender: str = models.CharField(max_length=12, choices=Gender, default="Gender")
    doctor_detail: str = models.TextField(max_length=500, default="Details..")
    address: str = models.CharField(max_length=500, default="Address")
    experience: Optional[int] = models.IntegerField(null=True, blank=True)  
    phone: str = models.CharField(max_length=20, validators=[RegexValidator(r'^\+?[0-9\-]+$')])
    specialization: str = models.CharField(max_length=50)
    availability: str = models.CharField(max_length=20, choices=Availability, default='available')
    
    def __str__(self) -> str:
        return str(self.doctor_name)
# Create your models here.
