from django.contrib import admin
from patients.models import Patients



class PatientsAdmin(admin.ModelAdmin):
    list_display=('patient_name','date_of_birth','age','phone','email','gender','status','last_visit','address','patient_doctor_name')

admin.site.register(Patients,PatientsAdmin)
    
# Register your models here.
