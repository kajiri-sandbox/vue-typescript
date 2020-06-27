<template>
  <div>
    <div>
      <div>
        <div>{{pokeId}}</div>
        <div>{{pokeName}}</div>
        <img :src="pokeImage">
      </div>
      <input type="text" v-model="state.inputTodo">
      <button type="button" @click="submit">追加</button>
    </div>
    <div>
      TODOS
        <p v-for="(todo, i) in state.todos" :key="i">
          <span>{{todo}}</span>
        </p>
    </div>
  </div>
</template>

<script lang="ts">
import { onMounted, defineComponent, reactive } from 'vue';
import axios from 'axios'

interface TodoState {
  todos: string[];
  inputTodo: string;
}

export default defineComponent({
  name: 'HelloWorld',
  async setup() {
    const state = reactive<TodoState>({
      todos: [] as string[],
      inputTodo: ''
    })

    const submit = () => {
      state.todos.push(state.inputTodo);
      state.inputTodo = '';
    }

    function getRandomInt(max: number): number {
      return Math.floor(Math.random() * Math.floor(max));
    }

    const pokeMaxCount = 808
    const number: number = getRandomInt(pokeMaxCount - 1) + 1
    const {data} = await axios.get(`https://pokeapi.co/api/v2/pokemon/${number}`)
    const pokeId = data.id
    const pokeName = data.name
    const { front_default, front_shiny } = data.sprites
    const random_boolean = Math.random() >= 0.5;
    const pokeImage = random_boolean ? front_default : front_shiny

    return {
      pokeName,
      pokeId,
      pokeImage,
      state,
      submit
    }
  }
});


</script>

<style scoped>
</style>
