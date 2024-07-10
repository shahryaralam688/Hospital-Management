from django.db import models
from django.core.validators import RegexValidator

class Doctors(models.Model):
    doctor_name =models.CharField(max_length=50)
    experience = models.IntegerField(null=True, blank=True)  
    phone = models.CharField(max_length=20, validators=[RegexValidator(r'^\+?[0-9\-]+$')])
    specialization = models.CharField(max_length=50)
    Availability =[
        ('available','available'),
        ('Not available','Not available'),
        ('Leave','leave'),
    ]
    availability  = models.CharField(max_length=20, choices=Availability, default='available')
    
    def __str__(self):
        return str(self.doctor_name)
# Create your models here.
