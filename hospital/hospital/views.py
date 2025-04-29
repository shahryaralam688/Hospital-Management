from django.shortcuts import render, redirect
from django.http import HttpRequest, HttpResponse
#from app.models import Patient,Doctor
from patients.models import Patients
from doctors.models import Doctors
from appointments.models import Appointment
from typing import Dict, Any, List, Optional, Union

def login_page(request: HttpRequest) -> HttpResponse:
    return render(request, 'login.html')

def BASE(request: HttpRequest) -> HttpResponse:
    return render(request, 'base.html')

def Index(request: HttpRequest) -> HttpResponse:
    return render(request, 'index.html')

def Add_patient(request: HttpRequest) -> HttpResponse:
    if request.method == "POST":
        patient_name: str = request.POST.get('patient_name')
        date_of_birth: str = request.POST.get('date_of_birth')
        age: str = request.POST.get('age')
        phone: str = request.POST.get('phone')
        email: str = request.POST.get('email')
        gender: str = request.POST.get('gender')
        address: str = request.POST.get('address')
        
        patient = Patients(
            patient_name=patient_name,
            date_of_birth=date_of_birth,
            age=age,
            phone=phone,
            gender=gender,
            email=email,
            address=address,
        )
        patient.save()

    return render(request, 'patients/add_patient.html')

def patients(request: HttpRequest) -> HttpResponse:
    patientsdata: List[Patients] = Patients.objects.all().order_by('-last_visit')
    data: Dict[str, List[Patients]] = {
        'patientsdata': patientsdata
    }  
    return render(request, 'patients/patients.html', data)

    
def Patient_detials(request: HttpRequest) -> HttpResponse:
    return render(request, 'patients/patient-details.html')

def Edit_patient(request: HttpRequest) -> HttpResponse:
    return render(request, 'patients/edit-patient.html')


# All method related Doctors!


def doctors(request: HttpRequest) -> HttpResponse:
    doctorsdata: List[Doctors] = Doctors.objects.all()
    data: Dict[str, List[Doctors]] = {
        'doctorsdata': doctorsdata
    }
    return render(request, 'doctors/doctors.html', data)

def Add_doctors(request: HttpRequest) -> HttpResponse:
    if request.method == "POST":
        doctor_name: str = request.POST.get('doctor_name')
        date_of_birth: str = request.POST.get('date_of_birth')
        specialization: str = request.POST.get('specialization')
        experience: str = request.POST.get('experience')
        age: str = request.POST.get('age')
        phone: str = request.POST.get('phone')
        email: str = request.POST.get('email')
        gender: str = request.POST.get('gender')
        doctor_detail: str = request.POST.get('doctor_detail')
        address: str = request.POST.get('address')  # Corrected variable name
        # Debugging: Print received form data
        print(f"doctor_name: {doctor_name}")
        print(f"date_of_birth: {date_of_birth}")
        print(f"specialization: {specialization}")
        print(f"experience: {experience}")
        print(f"age: {age}")
        print(f"phone: {phone}")
        print(f"email: {email}")
        print(f"gender: {gender}")
        print(f"doctor_detail: {doctor_detail}")
        print(f"address: {address}")
        
        doctor = Doctors(
            doctor_name=doctor_name,
            date_of_birth=date_of_birth,
            specialization=specialization,
            experience=experience,
            age=age,
            phone=phone,
            email=email,
            gender=gender,
            doctor_detail=doctor_detail,
            address=address,
        )
        doctor.save()  # Save the object to the database
        
    return render(request, 'doctors/add-doctor.html')


def Edit_doctors(request: HttpRequest) -> HttpResponse:
    if request.method == "POST":
        doctor_name: str = request.POST.get('doctor_name')
        dob: str = request.POST.get('dob')
        age: str = request.POST.get('age')
        phone: str = request.POST.get('phone')
        email: str = request.POST.get('email')
        gender: str = request.POST.get('gender')
        address: str = request.POST.get('address')
        status: str = request.POST.get('status')
        specialization: str = request.POST.get('specialiazation')
        experience_level: str = request.POST.get('experience_level')
        
        patient = Patients(
            doctor_Name=doctor_name,
            date_of_birth=dob,
            age=age,
            phone=phone,
            gender=gender,
            email=email,
            address=address,
            status=status,
            specialization=specialization,
            experience_level=experience_level
        )
        patient.save()
    return render(request, 'doctors/edit-doctor.html')

def Doctors_details(request: HttpRequest) -> HttpResponse:
    return render(request, 'doctors/about-doctor.html')

# All method related Appointment!


def appointments(request: HttpRequest) -> HttpResponse:
    appointmensdata: List[Appointment] = Appointment.objects.all()
    data: Dict[str, List[Appointment]] = {
        'appointmentsdata': appointmensdata
    }  
    
    return render(request, 'appointments/appointments.html', data)

def Add_appointment(request: HttpRequest) -> HttpResponse:
    return render(request, 'appointments/add-appointment.html')

def Edit_appointment(request: HttpRequest) -> HttpResponse:
    return render(request, 'appointments/edit-appointment.html')

def Appointment_details(request: HttpRequest) -> HttpResponse:
    return render(request, 'appointments/about-appointment.html')


# All method related Payment!
def Payments(requests: HttpRequest) -> HttpResponse:
    return render(requests, 'payments/payments.html')

def Add_payments(requests: HttpRequest) -> HttpResponse:
    return render(requests, 'payments/add-payment.html')

def Payments_details(requests: HttpRequest) -> HttpResponse:
    return render(requests, 'payments/about-payment.html')


#ALl method related room
def Rooms(request: HttpRequest) -> HttpResponse:
    return render(request, 'rooms/rooms.html')

def Add_room(request: HttpRequest) -> HttpResponse:
    return render(request, 'rooms/add-room.html')

def Edit_room(request: HttpRequest) -> HttpResponse:
    return render(request, 'rooms/edit-room.html')
