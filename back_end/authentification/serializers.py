from rest_framework import serializers
from .models import *

class user_serializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)  # Add password field

    class Meta:
        model = CustomUser
        fields = ['email', 'first_name', 'last_name', 'password']

    def create(self, validated_data):
        password = validated_data.pop('password', None)  # Extract password
        instance = self.Meta.model(**validated_data)
        if password is not None:
            instance.set_password(password)  # Set password securely
        instance.save()
        return instance