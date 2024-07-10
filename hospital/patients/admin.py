from django.contrib import admin
from patients.models import Patients



class PatientsAdmin(admin.ModelAdmin):
    list_display=('patient_name','age','phone','status','last_visit')

admin.site.register(Patients,PatientsAdmin)
    
# Register your models here.
