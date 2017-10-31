import { AppRegistry } from 'react-native';

const store = require('./dist/store');


AppRegistry.registerComponent('jjdl', store.init());
