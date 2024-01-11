<script setup>
const config = useRuntimeConfig()

import { ref } from 'vue'
import axios from 'axios'

console.log(config.public.whisperingApiHost)

const uploadedFile = ref(null)
const transcription = ref(null)
const summary = ref(null)

const onFileChange = (e) => {
  uploadedFile.value = e.target.files[0]
}

const onTranscribe = async () => {
  console.log('transcribing')
  transcription.value = null
  summary.value = null

  const apiUrl = 'http://localhost:8000/v1/transcribe';
  const apiKey = '1234567890';

  try {
    const formData = new FormData();
    formData.append('file', uploadedFile.value);

    const response = await axios.post(apiUrl, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
        'X-API-KEY': apiKey,
      },
    });

    // Handle the response data here
    console.log('Response:', response.data);
    transcription.value = response.data.transcription
    summary.value = response.data.summary
  } catch (error) {
    // Handle errors here
    console.error('Error:', error);
  }
}
</script>

<template>
  <div>
    <form @submit.prevent="onTranscribe">
      <input type="file" @change="onFileChange" />
      <button type="submit">Transcribe</button>
    </form>

    <div>
      <div>
        <h2>Transcription</h2>
        <p>{{ transcription }}</p>
      </div>

      <div>
        <h2>Summary</h2>
        <p>{{ summary }}</p>
      </div>
    </div>
  </div>
</template>
