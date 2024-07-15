from django.db import models
from django.core.validators import RegexValidator
from django.utils import timezone
from doctors.models import Doctors




class Patients(models.Model):
    STATUS_CHOICES = [
        ('Pending', 'Pending'),
        ('Complete', 'Complete'),
        ('Cancel', 'Cancelled'),
    ]
    Gender =[
        ('Male','Male'),
        ('female','female'),
        ('Other','Other'),        
    ]
    
    patient_name  = models.CharField(max_length=50)
    date_of_birth = models.CharField(max_length=12,default="Date Of Birth")
    age           = models.IntegerField(null=True, blank=True, default="Age")
    patient_doctor_name =models.CharField(Doctors,max_length=100,default="Doctor Name")  
    phone         = models.CharField(max_length=20, validators=[RegexValidator(r'^\+?[0-9\-]+$')])
    email         = models.EmailField(default="abc@gmail.com")
    gender        = models.CharField(max_length=10, choices=Gender, default="Gender")
    status        = models.CharField(max_length=10, choices=STATUS_CHOICES, default='Status')
    last_visit    = models.DateTimeField(default=timezone.now)
    address       = models.CharField(max_length=200, default="Address")
    
    def __str__(self):
        return str(self.patient_name)
# Create your models here.
