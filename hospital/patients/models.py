from django.db import models
from django.core.validators import RegexValidator
from django.utils import timezone



class Patients(models.Model):
    patient_name =models.CharField(max_length=50)
    age = models.IntegerField(null=True, blank=True)  
    phone = models.CharField(max_length=20, validators=[RegexValidator(r'^\+?[0-9\-]+$')])
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('complete', 'Complete'),
        ('cancel', 'Cancelled'),
    ]
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='pending')
    last_visit = models.DateTimeField(default=timezone.now)
# Create your models here.
