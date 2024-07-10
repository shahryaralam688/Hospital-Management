from django.contrib import admin
from appointments.models import Appointment

# Register your models here.
class AppointmentsAdmin(admin.ModelAdmin):
    list_display=('appointment_id','patient_id','token_number','doctor_name','problem','status')

admin.site.register(Appointment,AppointmentsAdmin)