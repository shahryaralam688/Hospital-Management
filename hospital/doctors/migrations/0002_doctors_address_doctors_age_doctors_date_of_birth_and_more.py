# Generated by Django 4.2.7 on 2024-07-15 10:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('doctors', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='doctors',
            name='address',
            field=models.CharField(default='Address', max_length=500),
        ),
        migrations.AddField(
            model_name='doctors',
            name='age',
            field=models.IntegerField(blank=True, default='00', null=True),
        ),
        migrations.AddField(
            model_name='doctors',
            name='date_of_birth',
            field=models.CharField(default='Date Of Birth', max_length=12),
        ),
        migrations.AddField(
            model_name='doctors',
            name='doctor_detail',
            field=models.TextField(default='Details..', max_length=500),
        ),
        migrations.AddField(
            model_name='doctors',
            name='email',
            field=models.EmailField(default='abc@gmail.com', max_length=254),
        ),
        migrations.AddField(
            model_name='doctors',
            name='gender',
            field=models.CharField(choices=[('Male', 'Male'), ('female', 'female'), ('Other', 'Other')], default='Gender', max_length=12),
        ),
        migrations.AlterField(
            model_name='doctors',
            name='availability',
            field=models.CharField(choices=[('Available', 'Available'), ('Not Available', 'Not Available'), ('Leave', 'Leave')], default='available', max_length=20),
        ),
    ]
