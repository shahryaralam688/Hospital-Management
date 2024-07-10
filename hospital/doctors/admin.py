from django.contrib import admin
from doctors.models import Doctors



class DoctorsAdmin(admin.ModelAdmin):
    list_display=('doctor_name','experience','phone','specialization','availability')

admin.site.register(Doctors,DoctorsAdmin)
# Register your models here.
