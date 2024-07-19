from django.contrib import admin
from django.urls import path

from .import views

urlpatterns = [
    path('admin/', admin.site.urls),
    
    path('', views.Index , name= 'index'),
    path('base',views.BASE,name='base'),

    path('add-patient',views.Add_patient,name='add_patient'),
    path('patient-details',views.Patient_detials ,name='patients_details'),
    path('edit-patient',views.Edit_patient ,name='edit_patients'),
    path('patients',views.patients ,name='patients'),
    path('login.html', views.login_page , name= 'login'),
    
    
    
    #Doctor method url
    path('add-doctor', views.Add_doctors, name= 'add-doctor'),
    path('doctors',views.doctors, name= 'doctors'),
    path('about-doctor',views.Doctors_details, name= 'about-doctor'),
    path('edit-doctor',views.Edit_doctors, name= 'edit-doctor'),
    
    
    #Appointment method url
    path('add-appointment', views.Add_appointment , name= 'add-appointment'),
    path('appointments',views.appointments, name= 'appointments'),
    path('about-appointment',views.Appointment_details, name= 'appointment-detail'),
    path('edit-appointment',views.Edit_appointment, name= 'edit-appointment'),
    
    
    #Payment method Url
    path('add-payment', views.Add_payments,name ='add-payment'),
    path('payments', views.Payments, name='payments'),
    path('about-payment',views.Payments_details, name= 'payment-details'),
    
    
    #Room method url
    path('rooms', views.Rooms, name ='rooms'),
    path('edit', views.Edit_room, name = 'edit-room'),
    path('add-room',views.Add_room, name= 'add-room'),
]