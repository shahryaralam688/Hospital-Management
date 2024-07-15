from django.db import models
from django.core.validators import RegexValidator

class Doctors(models.Model):
    #Date Of Birth Age  Email Gender Doctor detail address
    Gender =[
        ('Male','Male'),
        ('female','female'),
        ('Other','Other'),        
    ]
    Availability =[
        ('Available','Available'),
        ('Not Available','Not Available'),
        ('Leave','Leave'),
    ]
    doctor_name =models.CharField(max_length=50)
    date_of_birth = models.CharField(max_length=12,default="Date Of Birth")
    age           = models.IntegerField(null=True, blank=True, default="Age")
    email         = models.EmailField(default="abc@gmail.com")
    gender = models.CharField(max_length=12, choices=Gender, default="Gender")
    doctor_detail = models.TextField(max_length=500, default="Details..")
    address = models.CharField(max_length=500, default="Address")
    experience = models.IntegerField(null=True, blank=True)  
    phone = models.CharField(max_length=20, validators=[RegexValidator(r'^\+?[0-9\-]+$')])
    specialization = models.CharField(max_length=50)
    
    availability  = models.CharField(max_length=20, choices=Availability, default='available')
    
    def __str__(self):
        return str(self.doctor_name)
# Create your models here.
