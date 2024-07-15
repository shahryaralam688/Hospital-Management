from django.contrib import admin
from doctors.models import Doctors



class DoctorsAdmin(admin.ModelAdmin):
    list_display=('doctor_name',
                  'date_of_birth',
                  'email',
                  'age',
                  'doctor_detail',
                  'gender',
                  'experience',
                  'phone',
                  'address',
                  'specialization',
                  'availability')

admin.site.register(Doctors,DoctorsAdmin)
# Register your models here.
