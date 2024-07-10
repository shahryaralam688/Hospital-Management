from django.shortcuts import render,redirect
#from app.models import Patient,Doctor
from patients.models import Patients
from doctors.models import Doctors
from appointments.models import Appointment

def login_page(request):
    return render(request,'login.html')
def BASE(request):
    return render(request,'base.html')
def Index(request):
    return render(request, 'index.html')
def Add_patient(request):
    if request.method == "POST":
        patient_name = request.POST.get('patient_name')
        dob = request.POST.get('dob')
        age = request.POST.get('age')
        phone = request.POST.get('phone')
        email = request.POST.get('email')
        gender = request.POST.get('gender')
        address = request.POST.get('address')
        status = request.POST.get('status')

        patient = Patients(
            patient_Name = patient_name,
            date_of_birth = dob,
            age = age,
            phone = phone,
            gender = gender,
            email = email,
            address = address,
            status =status,
        )
        patient.save()

    return render(request,'patients/add_patient.html')
def patients(request):
    patientsdata = Patients.objects.all().order_by('-last_visit')
    data ={
        'patientsdata':patientsdata
    }  
    return render(request,'patients/patients.html', data)

    
def Patient_detials(request ):
    return render(request, 'patients/patient-details.html')
def Edit_patient(request):
    return render(request, 'patients/edit-patient.html')


# All method related Doctors!


def doctors(request):
    doctorsdata = Doctors.objects.all()
    data ={
        'doctorsdata':doctorsdata
    }
    return render(request, 'doctors/doctors.html', data)

def Add_doctors(request):
    return render(request, 'doctors/add-doctor.html')

def Edit_doctors(request):
    if request.method == "POST":
        doctor_name = request.POST.get('doctor_name')
        dob = request.POST.get('dob')
        age = request.POST.get('age')
        phone = request.POST.get('phone')
        email = request.POST.get('email')
        gender = request.POST.get('gender')
        address = request.POST.get('address')
        status = request.POST.get('status')
        specialization = request.POST.get('specialiazation')
        experience_level= request.POST.get('experience_level')
        
        patient = Patients(
            doctor_Name = doctor_name,
            date_of_birth = dob,
            age = age,
            phone = phone,
            gender = gender,
            email = email,
            address = address,
            status =status,
            specialization=specialization,
            experience_level=experience_level
        )
        patient.save()
    
    
    
    return render(request, 'doctors/edit-doctor.html')

def Doctors_details(request):
    return render(request, 'doctors/about-doctor.html')

# All method related Appointment!


def appointments(request):
    appointmensdata = Appointment.objects.all()
    data ={
        'appointmentsdata':appointmensdata
    }  
    
    return render(request, 'appointments/appointments.html', data)

def Add_appointment(request):
    return render(request, 'appointments/add-appointment.html')

def Edit_appointment(request):
    return render(request, 'appointments/edit-appointment.html')

def Appointment_details(request):
    return render(request, 'appointments/about-appointment.html')


# All method related Payment!
def Payments(requests):
    return render(requests, 'payments/payments.html')
def Add_payments(requests):
    return render(requests, 'payments/add-payment.html')
def Payments_details(requests):
    return render(requests, 'payments/about-payment.html')


#ALl method related room
def Rooms(request):
    return render(request, 'rooms/rooms.html')
def Add_room(request):
    return render(request,'rooms/add-room.html')
def Edit_room(request):
    return render(request, 'rooms/edit-room.html')