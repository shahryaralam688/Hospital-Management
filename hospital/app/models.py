from django.db import models



# create model for Doctors.
class Doctor(models.Model):
    doctor_Name = models.CharField(max_length=100)
    Date_of_birth = models.CharField(max_length=100)
    experience_level = models.IntegerField()
    age = models.IntegerField()
    specialization = models.CharField(max_length=50) 
    phone = models.IntegerField()
    email = models.EmailField(max_length=100)
    gender = models.CharField(max_length=50)
    address = models.TextField()
    status = models.CharField(max_length=50, default='Null')
    def __str__(self):
        return self.doctor_Name
# Create your models here.

class Patient(models.Model):
    patient_Name = models.CharField(max_length=100)
    Date_of_birth = models.DateTimeField(null=True, blank=True)
    age = models.IntegerField()
    phone = models.IntegerField()
    email = models.EmailField(max_length=100)
    gender = models.CharField(max_length=50)
    address = models.TextField()
    status = models.CharField(max_length=50, default='Null')
    last_view= models.DateTimeField(null=True, blank=True)
    def __str__(self):
        return self.patient_Name
        return self.patient_Name