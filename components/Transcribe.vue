<script setup>
const config = useRuntimeConfig()

import { ref } from 'vue'
import axios from 'axios'

console.log(config.public.apiBase)

const transcription = ref(null)
const summary = ref(null)

const state = reactive({
  file: File
})
const onFileChange = (e) => {
  state.file = e.target.files[0]
}

const onTranscribe = async () => {
  console.log('transcribing')
  transcription.value = null
  summary.value = null

  const apiUrl = `${config.public.apiBase}/v1/transcribe`;
  const apiKey = '1234567890';

  try {
    const formData = new FormData();
    formData.append('file', state.file);

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
    <UCard>
      <template #header>
        <div class="font-bold text-xl">Audio to Text</div>
      </template>

      <UForm :state="state" class="space-y-4" @submit="onTranscribe">
        <UFormGroup label="Audio File" name="file">
          <UInput type="file" @change="onFileChange" />
        </UFormGroup>

        <UButton type="submit">
          Transcribe
        </UButton>
      </UForm>

      <UDivider label="Processing Result" class="my-4" />
      <div>
        <UCard>
          <template #header>
            <div class="font-bold">Transcription</div>
          </template>
          <p>{{ transcription }}</p>
        </UCard>

        <UCard class="mt-4">
          <template #header>
            <div class="font-bold">Summary</div>
          </template>
          <p>{{ summary }}</p>
        </UCard>
      </div>
    </UCard>
  </div>
</template>
