'use strict';

import React from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    TextInput,
    View,
    Image
} from 'react-native';


function setup(): ReactClass<Object> {
	return Root;
}
module.exports = setup;

class Root extends React.Component {

     constructor(props) {
        super(props);
        this.state = {text: ''};
    }
    
    render() {
        // var contents = this.props["scores"].map(
        //     score =>
        //      <Text key={score.name}>{score.name}:{score.value}{"\n"}</Text>
        // );
        return (
            <View style={styles.container}>
                <Text style={styles.highScoresTitle}>
                    2048 High Scores!!!
                </Text>
                <Text style={styles.scores}>        
                    {/* {contents} */}
                </Text>
				<View style={{alignItems: 'center'}}>
					<Greeting name='Rexxar' />
					<Greeting name='Jaina' />
					<Greeting name='Valeera' />
				</View>
                <TextInput style={{height: 40, alignItems: 'center', textAlign: 'center'}}  
                                     placeholder="Type here to translate!" 
                                     onChangeText={(text) => this.setState({text})}
                />
                <Text style={{padding: 10, fontSize: 42}}>
                   {this.state.text.split(' ').map((word) => word && '🍕').join(' ')}
                </Text>
				<Blink text='Blink' />
                <Image source={require('./img/2ha.jpg')} style={{width: 100, height: 100}} />
                <Image
                    style={{width: 100, height: 100}}
                    source={{uri:'https://facebook.github.io/react/img/logo_og.png'}}
                />
			</View>
            
        );
    }
}

class Greeting extends React.Component {
    render() {
        return (
            <Text>Hello {this.props.name}!</Text>
        );
    }
}

class Blink extends React.Component {
	constructor(props) {
		super(props);
		this.state = { showText : true };

		setInterval(() => {
			this.setState(previousState => {
				return { showText : !previousState.showText };
			})
		}, 500);
	}
	render()  {
		let display = this.state.showText ? this.props.text : '';
		return (
			<Text>{display}</Text>	
		);
	}
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#FFFFFF',
    },
    highScoresTitle: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    scores: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
});
